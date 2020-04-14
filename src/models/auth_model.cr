require "../common/code_responses"
require "../common/common_constants"

# Модель для проведения аутентификации
class AuthModel
    # Вход через электронную почту
    # Возвращает идентификатор сессии или код результата 
    def loginByMail(login : String, password : String) : String | Int32
        resp = Crest.post(
            "http://localhost:3000/user/loginByMail",
            headers: {"Content-Type" => "application/json"},
            form: { login: login, password: password }.to_json
        )

        data = JSON.parse(resp.body)
        code = data["code"].as_i
        return code if code != OK_CODE
        return data["sessionId"].to_s
    end

    # Отправляет ссылку на регистрацию на почту
    # Возвращает код результата
    def sendRegisterLink(login : String, password : String) : Int32
        # Создаёт заявку на регистрацию
        resp = Crest.post(
            "http://localhost:3000/user/createRegisterTicket",
            headers: {"Content-Type" => "application/json"},
            form: { login: login, password: password }.to_json
        )

        data = JSON.parse(resp.body)        
        code = data["code"].as_i
        ticketId = data["ticketId"]?
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

        resp = Crest.post(
            "http://localhost:3000/mail/send",
            headers: {"Content-Type" => "application/json"},
            form: { 
                subject: "TeamLead - регистрация аккаунта", 
                message: message,
                recepient: login
            }.to_json
        )

        data = JSON.parse(resp.body)        
        code = data["code"].as_i        
        return code
    end

    # Отправляет подтверждение регистрации по почте
    def confirmMailRegister(ticketId : String)
        resp = Crest.get(
            "http://localhost:3000/user/confirmRegisterTicket/#{ticketId}"
        )

        data = JSON.parse(resp.body)        
        code = data["code"].as_i
        return code
    end
end