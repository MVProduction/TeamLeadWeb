require "kemal"

require "../common/template_factory"
require "../services/user_service"
require "../services/post_service"
require "../services/models/view_post_data"

get "/post/:id" do |env|
  id = env.params.url["id"]?.try &.to_i64
  # TODO: страница что объявление не найдено
  if id.nil?
    env.response.status = HTTP::Status::NOT_FOUND
    next
  end

  userService = UserService.new
  postService = PostService.new

  postView = TemplateFactory.instance.getTemplate("main/view_post_view.html")
  postView.render({
    loginUser: userService.getUserInfoFromCookie(env),
    post: postService.getPost(id)
  })
end