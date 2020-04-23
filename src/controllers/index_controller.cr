require "kemal"

require "../common/template_factory"
require "../services/quote_service"
require "../services/user_service"
require "../services/models/user_info_data"

# Количество объявлений на одной странице
PAGE_POST_COUNT = 3

# Количество символов в тексте объявления
TEXT_CHAR_COUNT = 200

get "/" do |env|
  postService = PostService.instance  
  userService = UserService.instance
  quoteService = QuoteService.instance  
  
  # Номер страницы
  firstId = env.params.query["firstId"]?

  # Если есть номер страницы и он больше единицы
  # if !firstId.nil?    
  #   postList = postService.getPosts(pn, PAGE_POST_COUNT, TEXT_CHAR_COUNT)
  # else
  #   postList = postService.getPosts(PAGE_POST_COUNT, TEXT_CHAR_COUNT)
  # end

  postRes = postService.getPosts(
    firstId: nil,
    limit: PAGE_POST_COUNT,
    textLen: TEXT_CHAR_COUNT)

  pageCount = (postRes[1] / PAGE_POST_COUNT).floor
  
  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userService.getUserInfoFromCookie(env),
      postList: postRes[0],
      pageIndexes: pageCount > 0 ? (0..pageCount).to_a : Array(Int32).new,
      hasPages: pageCount > 0,
      quote: quoteService.getRandomQuote()
    })
end