require "kemal"

require "../common/template_factory"

# Возвращает вид создания нового объявления
get "/create_post" do |env|
  createPostView = TemplateFactory.instance.getTemplate("main/create_post_view.html")
  createPostView.render()
end