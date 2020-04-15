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

get "/auth/resetPassword" do
  loginView = TemplateFactory.instance.getTemplate("auth/reset_password_view.html")
  loginView.render()
end

# Запрос входа по электронной почте пользователя и паролем
post "/auth/loginByMail" do |env|
  login = env.params.json["login"]?.as?(String)
  password = env.params.json["password"]?.as?(String)
  
  if login.nil? || password.nil?
    next getCodeResponse(BAD_REQUEST)
  end

  model = AuthModel.new()
  result = model.loginByMail(login, password)

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

# Создаёт ссылку на регистрацию
# Отправляет на почту письмо
# Возвращает код ответа
post "/auth/sendRegisterLink" do |env|
  login = env.params.json["login"]?.as?(String)
  password = env.params.json["password"]?.as?(String)
  
  if login.nil? || password.nil?
    next getCodeResponse(BAD_REQUEST)
  end
  
  model = AuthModel.new()
  code = model.sendRegisterLink(login, password)
  next getCodeResponse(code)
end

# Подтверждает регистрацию по электронной почте
# При подтверждении создаётся пользователь
get "/auth/confirmMailRegister/:id" do |env|
  ticketId = env.params.url["id"]
  p ticketId  
  model = AuthModel.new()
  code = model.confirmMailRegister(ticketId)
  
  # TODO: обрабатывать код ошибки
  if code == OK_CODE
    confirmView = TemplateFactory.instance.getTemplate("auth/register_complete_view.html")
    next confirmView.render()
  end
end