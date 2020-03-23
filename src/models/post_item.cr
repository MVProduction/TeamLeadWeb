# Объявление пользователя
@[Crinja::Attributes]
class PostItem
    include Crinja::Object::Auto

    # Заголовок объявления
    getter postTitle : String

    # Текст объявления
    getter postText : String

    # Конструктор
    def initialize(@postTitle, @postText)        
    end
end