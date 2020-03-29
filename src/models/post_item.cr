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

    # Конструктор
    def initialize(@postId ,@postTitle, @postText)        
    end
end