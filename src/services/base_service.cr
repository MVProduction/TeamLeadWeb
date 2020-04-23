require "crest"

# Базовый сервис
class BaseService
    # Отправляет GET запрос и возвращает json ответ JSON::Any
    # path должен быть формата /path1/path2/:some?param=value
    def sendGet(path : String) : JSON::Any
        uri = "http://#{API_HOST}:#{API_PORT}#{path}"
        p uri
        resp = Crest.get(uri)
        data = JSON.parse(resp.body)
        return data
    end

    # Отправляет POST запрос с телом JSON
    # параметр json может быть чем угодно с методом to_json
    # Возвращает json ответ JSON::Any
    def sendPost(path : String, json) : JSON::Any
        resp = Crest.post(
            "http://#{API_HOST}:#{API_PORT}#{path}",
            headers: {"Content-Type" => "application/json"},
            form: json.to_json
        )

        data = JSON.parse(resp.body)
        return data
    end
end