require "crest"
require "./post_item"

# Модель начальной страницы с объявлениями
@[Crinja::Attributes]
class IndexModel
    include Crinja::Object::Auto        

    @@my_quotes = ["Стартап - это легко. Но не всегда!", 
        "Если вы не создали стартап, то кто то другой создал!",
        "Что бы начать стартап, нужно начать стартап!",
        "Упорствуйте и что-нибудь получится. Но возможно не то что Вы хотели!",
        "Люди могут скопировать Вашу идею. Но они не могут скопировать то что Вы собираетесь сделать. Особенно если Вы ничего не собираетесь делать!"
    ]

    # Возвращает мою цитату случайным образом
    def getRandomQuote()
        @@my_quotes.sample(1)[0]
    end

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32, textLen : Int32) : Array(PostItem)        
        resp = Crest.get("http://localhost:3000/posts/getPopular/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItem).new unless posts

        return posts.map { |x|
            PostItem.fromJson(x)
        }
    end

    # Возвращает новые объявления
    def getRecentPosts(count : Int32, textLen : Int32) : Array(PostItem)        
        resp = Crest.get("http://localhost:3000/posts/getRecent/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItem).new unless posts

        return posts.map { |x|
            PostItem.fromJson(x)
        }
    end

    # Конструктор
    def initialize
    end
end