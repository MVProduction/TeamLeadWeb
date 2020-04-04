require "kemal"

require "../common/template_factory"

get "/login" do
  loginView = TemplateFactory.instance.getTemplate("auth/login_view.html")
  loginView.render()
end

get "/register" do
  loginView = TemplateFactory.instance.getTemplate("auth/register_view.html")
  loginView.render()
end