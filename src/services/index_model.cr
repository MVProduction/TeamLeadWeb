require "crest"
require "./models/post_item_data"

# Модель начальной страницы с объявлениями
# TODO: резделить на несколько моделей
@[Crinja::Attributes]
class IndexModel
    include Crinja::Object::Auto        

    @@my_quotes = ["Стартап - это легко. Но не всегда!", 
        "Если вы не создали стартап, то кто то другой создал!",
        "Что бы начать стартап, нужно начать стартап!",
        "Упорствуйте и что-нибудь получится. Но возможно не то что Вы хотели!",
        "Люди могут скопировать Вашу идею. Но они не могут скопировать то что Вы собираетесь сделать. Особенно если Вы ничего не собираетесь делать!",
        "Дорогу осилит идущий. Так что не бегите!"
    ]

    # Возвращает мою цитату случайным образом
    def getRandomQuote()
        @@my_quotes.sample(1)[0]
    end

    # Возвращает популярные объявления
    def getPopularPosts(count : Int32, textLen : Int32) : Array(PostItemData)        
        resp = Crest.get("http://localhost:3000/posts/getPopular/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end

    # Возвращает новые объявления
    def getRecentPosts(count : Int32, textLen : Int32) : Array(PostItemData)        
        resp = Crest.get("http://localhost:3000/posts/getRecent/#{count}?textLen=#{textLen}")
        data = JSON.parse(resp.body)        
        posts = data["posts"]?.try &.as_a?

        return Array(PostItemData).new unless posts

        return posts.map { |x|
            PostItemData.fromJson(x)
        }
    end
end