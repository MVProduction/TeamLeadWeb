require "kemal"

require "../common/template_factory"
require "../models/index_model"

get "/" do
  indexModel = IndexModel.new

  indexView = TemplateFactory.instance.getTemplate("main/index_view.html")
  indexView.render(
    { 
      postList: indexModel.getRecentPosts(20, 200),
      quote: indexModel.getRandomQuote()
    })
end