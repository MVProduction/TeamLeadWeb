require "crinja"

# Объявление/проект пользователя
@[Crinja::Attributes]
class PostItemData
    include Crinja::Object::Auto

    # Идентификатор объявления
    getter postId : Int64

    # Заголовок объявления
    getter postTitle : String

    # Текст объявления
    getter postText : String

    # Создаёт из Json
    def self.fromJson(data : JSON::Any)        
        PostItemData.new(
            data["postId"].as_i64, 
            data["postTitle"].as_s, 
            data["postText"].as_s
        )
    end

    # Конструктор
    def initialize(@postId ,@postTitle, @postText)        
    end    
end