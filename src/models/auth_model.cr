require "../common/code_responses"

# Модель для проведения аутентификации
class AuthModel
    # Вход через электронную почту
    # Возвращает идентификатор сессии или код результата 
    def mail_login(login : String, password : String) : String | Int32
        resp = Crest.post(
            "http://localhost:3000/user/mailLogin",
            headers: {"Content-Type" => "application/json"},
            form: { login: login, password: password }.to_json
        )

        data = JSON.parse(resp.body)        
        code = data["code"].as_i
        return code if code != OK_CODE
        return data["sessionId"].to_s
    end
end