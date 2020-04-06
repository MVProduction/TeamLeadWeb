require "kemal"

require "../common/template_factory"

get "/auth/login" do
  loginView = TemplateFactory.instance.getTemplate("auth/login_view.html")
  loginView.render()
end

get "/auth/register" do
  loginView = TemplateFactory.instance.getTemplate("auth/register_view.html")
  loginView.render()
end

get "/auth/reset_password" do
  loginView = TemplateFactory.instance.getTemplate("auth/reset_password_view.html")
  loginView.render()
end

# Запрос входа по электронной почте пользователя и паролем
post "/mail_login" do |env|
  begin
    email = env.params.json["email"]?.as?(String)
    password = env.params.json["password"]?.as?(String)
  rescue        
      next getCodeResponse(INTERNAL_ERROR)
  end
end