require "../common/code_responses"
require "../common/common_constants"
require "./base_service"

# Сервис для проведения аутентификации
class AuthService < BaseService
    # Экземпляр
    @@instance = AuthService.new

    # Возвращает экземпляр
    def self.instance
        @@instance
    end

    # Вход через электронную почту
    # Возвращает идентификатор сессии или код результата 
    def loginByMail(login : String, password : String) : String | Int32
        resp = sendPost(
            "/user/loginByMail",
            json: { login: login, password: password }
        )
        
        code = resp["code"].as_i
        return code if code != OK_CODE
        return resp["sessionId"].to_s
    end

    # Отправляет ссылку на регистрацию на почту
    # Возвращает код результата
    def sendRegisterLink(login : String, password : String) : Int32
        # Создаёт заявку на регистрацию
        resp = sendPost(
            "/user/createRegisterTicket",            
            json: { login: login, password: password }
        )

        code = resp["code"].as_i
        ticketId = resp["ticketId"]?
        if code != OK_CODE || ticketId.nil?
            return code
        end

        # TODO: интернализация
        ticketUrl = "http://#{SERVICE_HOST}:#{SERVICE_PORT}/auth/confirmMailRegister/#{ticketId}"

        # Отправляет письмо со ссылкой завершения регистрации
        message = <<-MAIL
            Здравствуйте, дорогой пользователь!

            Для продолжения регистрации перейдите по ссылке:
            #{ticketUrl}

            Это письмо сформировано автоматически. Пожалуйста, не отвечайте на него.

            --
            С уважением, комманда TeamLead.
        MAIL

        resp = sendPost(
            "/mail/send",            
            json: { 
                subject: "TeamLead - регистрация аккаунта", 
                message: message,
                recepient: login
            }
        )
              
        code = resp["code"].as_i        
        return code
    end

    # Отправляет подтверждение регистрации по почте
    def confirmMailRegister(ticketId : String)
        resp = sendGet(
            "/user/confirmRegisterTicket/#{ticketId}"
        )
        
        code = resp["code"].as_i
        return code
    end
end