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
    
    getter posts : Array(PostItem)

    def initialize
        @posts = Array(PostItem).new
        @posts << PostItem.new("Ищу людей для стартапа", "Супер идея")
        @posts << PostItem.new("У меня есть идея", "Вообщем слушайте")
    end
end