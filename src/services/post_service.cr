require "crest"
require "./models/post_item_data"
require "../common/common_constants"
require "./base_service"

# Сервис получения объявления/проекта
class PostService < BaseService
    # Экземпляр
    @@instance = PostService.new

    # Возвращает экземпляр
    def self.instance
        @@instance
    end

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItemData        
        resp = sendGet("/posts/getById/#{id}")
        post = resp["post"]
        PostItemData.fromJson(post)
    end

    # Возвращает объявления от начального индекса с заданным колличеством
    def getRangePosts(firstId : Int64, count : Int32, textLen : Int32) : Array(PostItemData)
        resp = sendGet("/posts/getRange/#{firstId}/#{count}?textLen=#{textLen}")
        posts = resp["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32, textLen : Int32) : Array(PostItemData)
        resp = sendGet("/posts/getPopular/#{count}?textLen=#{textLen}")
        posts = resp["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end

    # Возвращает новые объявления
    def getRecentPosts(count : Int32, textLen : Int32) : Array(PostItemData)        
        resp = sendGet("/posts/getRecent/#{count}?textLen=#{textLen}")               
        posts = resp["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end
end