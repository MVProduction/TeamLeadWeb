require "kemal"

require "../common/code_responses"
require "../common/template_factory"
require "../models/auth_model"

# Отправляет код ответа
def getCodeResponse(code : Int32)
  {
      code: code
  }.to_json
end

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
post "/auth/mail_login" do |env|
  login = env.params.json["login"]?.as?(String)
  password = env.params.json["password"]?.as?(String)
  
  if login.nil? || password.nil?
    next getCodeResponse(BAD_REQUEST)
  end

  model = AuthModel.new()
  result = model.mail_login(login, password)

  case result
  when Int32
    next getCodeResponse(result)
  when String
    next {
      code: OK_CODE,
      sessionId: result
  }.to_json
  end  
end

# Регистрирует поьзователя по электронной почте и паролю
post "/auth/mail_register" do |env|
  login = env.params.json["login"]?.as?(String)
  password = env.params.json["password"]?.as?(String)
  
  if login.nil? || password.nil?
    next getCodeResponse(BAD_REQUEST)
  end

  model = AuthModel.new()
  result = model.mail_register(login, password)
end