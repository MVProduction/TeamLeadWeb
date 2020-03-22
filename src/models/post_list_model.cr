require "crest"

@[Crinja::Attributes]
class PostItem
    include Crinja::Object::Auto

    getter title : String
    getter text : String

    def initialize(@title, @text)        
    end
end

@[Crinja::Attributes]
class PostListModel
    include Crinja::Object::Auto
    
    @posts : Array(PostItem)

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32) : Array(PostItem)
        id = 3
        resp = Crest.get("http://localhost:3000/posts/getRange/#{id}/#{count}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItem).new unless posts

        return posts.map { |x|
            PostItem.new(x["postTitle"].as_s, x["postText"].as_s)
        }
    end

    def initialize
        @posts = Array(PostItem).new
    end
end