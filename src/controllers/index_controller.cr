require "kemal"

require "../models/index_model"
require "../common/template_factory"

get "/" do
  indexModel = IndexModel.new

  indexView = TemplateFactory.instance.getTemplate("index.html")
  indexView.render(
    { 
      postList: indexModel.getRecentPosts(20, 200),
      quote: indexModel.getRandomQuote()
    })
end