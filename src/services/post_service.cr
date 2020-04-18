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

    # Возвращает количество страниц для количества объявлений postInPage
    def getPageCount(postInPage : Int32) : Int64
        resp = sendGet("/posts/getPostCount")
        count = resp["postCount"].as_i64
        return (count / postInPage).to_i64
    end

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItemData        
        resp = sendGet("/posts/getById/#{id}")
        post = resp["post"]
        PostItemData.fromJson(post)
    end

    # Разбивает все объявления на страницы и возвращает 
    # Объявления в количестве postInPage по индексу pageIndex
    def getPostsByPage(pageIndex : Int32, postInPage : Int32, textLen : Int32) : Array(PostItemData)
        resp = sendGet("/posts/getByPage/#{pageIndex}/#{postInPage}?textLen=#{textLen}")
        posts = resp["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
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