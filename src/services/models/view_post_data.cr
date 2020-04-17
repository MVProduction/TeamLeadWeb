require "crest"
require "./post_item_data"
require "../../common/common_constants"

# Модель для вида обсуждения объявления
@[Crinja::Attributes]
class ViewPostModel
    include Crinja::Object::Auto

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItemData
        resp = Crest.get("http://localhost:3000/posts/getById/#{id}")
        data = JSON.parse(resp.body)
        post = data["post"]
        PostItemData.fromJson(post)
    end
end