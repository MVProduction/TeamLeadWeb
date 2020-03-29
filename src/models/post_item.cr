require "crinja"

# Объявление пользователя
@[Crinja::Attributes]
class PostItem
    include Crinja::Object::Auto

    # Идентификатор объявления
    getter postId : Int64

    # Заголовок объявления
    getter postTitle : String

    # Текст объявления
    getter postText : String

    # Создаёт из Json
    def self.fromJson(data)
        p typeof(data)
        PostItem.new(
            data["postId"].as_i64, 
            data["postTitle"].as_s, 
            data["postText"].as_s
        )
    end

    # Конструктор
    def initialize(@postId ,@postTitle, @postText)        
    end    
end