require "crest"
require "./models/post_item_data"
require "../common/common_constants"
require "./base_service"
require "uri"

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

    # Возвращает объявления
    def getPosts(
            firstid : Int64?, 
            limit : Int32?,
            textLen : Int32?
        ) : Array(PostItemData)

        path = "/posts/getPosts/"

        queryBuilder = HTTP::Params::Builder.new
        if limit
            query.add("limit", limit.to_s)
        end

        if textLen
            query.add("textLen", textLen.to_s)
        end        

        if firstid
            path += firstid
        end

        query = queryBuilder.to_s
        if !query.empty?
            path + "?" + query
        end
        
        resp = sendGet(path)

        posts = resp["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end    
end