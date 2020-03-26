require "crest"
require "./post_item"

# Модель списка
@[Crinja::Attributes]
class PostListModel
    include Crinja::Object::Auto        

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32, textLen : Int32) : Array(PostItem)        
        resp = Crest.get("http://localhost:3000/posts/getPopular/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItem).new unless posts

        return posts.map { |x|
            PostItem.new(x["postTitle"].as_s, x["postText"].as_s)
        }
    end

    # Возвращает новые объявления
    def getRecentPosts(count : Int32, textLen : Int32) : Array(PostItem)        
        resp = Crest.get("http://localhost:3000/posts/getRecent/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItem).new unless posts

        return posts.map { |x|
            PostItem.new(x["postTitle"].as_s, x["postText"].as_s)
        }
    end

    # Конструктор
    def initialize
    end
end