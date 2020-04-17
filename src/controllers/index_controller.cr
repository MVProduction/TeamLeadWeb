require "kemal"

require "../common/template_factory"
require "../services/quote_service"
require "../services/user_service"
require "../services/models/user_info_data"

get "/" do |env|
  postService = PostService.instance  
  userService = UserService.instance
  quoteService = QuoteService.instance  

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userService.getUserInfoFromCookie(env),
      postList: postService.getRecentPosts(20, 200),
      quote: quoteService.getRandomQuote()
    })
end