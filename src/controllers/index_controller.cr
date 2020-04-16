require "kemal"

require "../common/template_factory"
require "../models/index_model"
require "../models/user_model"

get "/" do |env|
  indexModel = IndexModel.new  
  userModel = UserModel.new

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      loginUser: userModel.getUserInfoFromCookie(env),
      postList: indexModel.getRecentPosts(20, 200),
      quote: indexModel.getRandomQuote()
    })
end