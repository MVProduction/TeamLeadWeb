require "crest"
require "./models/post_item_data"
require "../common/common_constants"

# Сервис получения объявления/проекта
@[Crinja::Attributes]
class PostService
    include Crinja::Object::Auto

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItemData
        resp = Crest.get("http://#{API_HOST}:#{API_PORT}/posts/getById/#{id}")
        data = JSON.parse(resp.body)
        post = data["post"]
        PostItemData.fromJson(post)
    end
end