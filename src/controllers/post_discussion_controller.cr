require "kemal"

require "../common/template_factory"
require "../models/post_discussion_model"

get "/post/:id" do |env|
  id = env.params.url["id"]?.try &.to_i64
  # TODO: страница что объявление не найдено
  if id.nil?
    env.response.status = HTTP::Status::NOT_FOUND
    next
  end

  postModel = PostDiscussionModel.new

  postView = TemplateFactory.instance.getTemplate("post_discussion_view.html")
  postView.render({
    post: postModel.getPost(id)
  })
end