require "kemal"

require "../common/template_factory"
require "../services/quote_service"
require "../services/user_service"
require "../services/models/user_info_data"

# Количество объявлений на одной странице
PAGE_POST_COUNT = 4

# Количество символов в тексте объявления
TEXT_CHAR_COUNT = 200

get "/" do |env|
  postService = PostService.instance  
  userService = UserService.instance
  quoteService = QuoteService.instance  
  
  # Номер страницы
  pageId = env.params.query["page"]?.try &.to_i64 || 1_i64  
  
  response = postService.getPostsByPage(
    page: pageId,
    postsInPage: PAGE_POST_COUNT,
    textLen: TEXT_CHAR_COUNT)
  
  pageCount = response[1]
  prevPageId = pageId - 1
  nextPageId = pageId + 1

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userService.getUserInfoFromCookie(env),
      postList: response[0],      
      pageIndexes: pageCount > 0 ? (0...pageCount).to_a : Array(Int32).new,
      prevPageId: (pageCount > 0) && (pageId > 1) ? prevPageId : nil,
      nextPageId: (pageCount > 0) && (nextPageId <= pageCount) ? nextPageId : nil,
      currentPage: pageId,
      quote: quoteService.getRandomQuote()
    })
end