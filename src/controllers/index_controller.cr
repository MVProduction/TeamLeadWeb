require "kemal"

require "../common/template_factory"
require "../services/index_model"
require "../services/user_service"
require "../services/models/user_info_data"

get "/" do |env|
  indexModel = IndexModel.new  
  userModel = UserService.new

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userModel.getUserInfoFromCookie(env),
      postList: indexModel.getRecentPosts(20, 200),
      quote: indexModel.getRandomQuote()
    })
end