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

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32, textLen : Int32) : Array(PostItemData)        
        resp = Crest.get("http://localhost:3000/posts/getPopular/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end

    # Возвращает новые объявления
    def getRecentPosts(count : Int32, textLen : Int32) : Array(PostItemData)        
        resp = Crest.get("http://localhost:3000/posts/getRecent/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end
end