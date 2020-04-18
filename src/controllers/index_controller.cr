require "kemal"

require "../common/template_factory"
require "../services/quote_service"
require "../services/user_service"
require "../services/models/user_info_data"

# Количество объявлений на одной странице
PAGE_POST_COUNT = 20

# Количество символов в тексте объявления
TEXT_CHAR_COUNT = 200

get "/" do |env|
  postService = PostService.instance  
  userService = UserService.instance
  quoteService = QuoteService.instance  
  
  # Запрашивает количество страниц
  pageCount = postService.getPageCount(PAGE_POST_COUNT)

  # Номер страницы
  pageNumber = env.params.query["page"]?

  # Если есть номер страницы и он больше единицы
  if !pageNumber.nil?
    pn = pageNumber.to_i32
    postList = postService.getPostsByPage(pn, PAGE_POST_COUNT, TEXT_CHAR_COUNT)
  else
    postList = postService.getRecentPosts(PAGE_POST_COUNT, TEXT_CHAR_COUNT)
  end

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userService.getUserInfoFromCookie(env),
      postList: postList,
      pageCount: pageCount,
      quote: quoteService.getRandomQuote()
    })
end