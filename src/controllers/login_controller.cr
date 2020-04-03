require "kemal"

require "../common/template_factory"

get "/login" do
  loginView = TemplateFactory.instance.getTemplate("login_view.html")
  loginView.render()
end