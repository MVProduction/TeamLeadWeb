require "crest"
require "./post_item"

# Модель для вида обсуждения объявления
@[Crinja::Attributes]
class PostDiscussionModel
    include Crinja::Object::Auto

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItem
        resp = Crest.get("http://localhost:3000/posts/getById/#{id}")
        data = JSON.parse(resp.body)
        post = data["post"]
        PostItem.fromJson(post)
    end
end