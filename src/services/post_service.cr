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

    # Возвращает объявление по идентификатору
    def getPost(id : Int64) : PostItemData        
        resp = sendGet("/posts/getById/#{id}")
        post = resp["post"]
        PostItemData.fromJson(post)
    end

    # Возвращает объявления
    def getPosts(
            firstId : Int64? = nil, 
            limit : Int32? = nil,
            textLen : Int32? = nil            
        ) : Tuple(Array(PostItemData), Int64?)

        path = "/posts/getPosts/"

        # Формирует запросы
        queryBuilder = HTTP::Params::Builder.new

        if firstId
            queryBuilder.add("firstId", firstId.to_s)
        end

        if limit
            queryBuilder.add("limit", limit.to_s)
        end

        if textLen
            queryBuilder.add("textLen", textLen.to_s)
        end      
        
        query = queryBuilder.to_s        
        if !query.empty?
            path = path + "?" + query
        end
        
        p path
        resp = sendGet(path)

        posts = resp["posts"]?.try &.as_a? || Array(JSON::Any).new                
        total = resp["total"]?.try &.as_i64? || 0_i64
        
        postArray = posts.map { |x|
            PostItemData.fromJson(x)
        }

        return { postArray, total }
    end    
end