require "crest"
require "./models/post_item_data"

# Сервис получения моих "гениальных" цитат :)
class QuoteService
    # Экземпляр
    @@instance = QuoteService.new

    # Возвращает экземпляр
    def self.instance
        @@instance
    end

    # Список цитат
    # TODO: интернализация :)
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
end