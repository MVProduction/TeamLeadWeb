require "kemal"

require "../common/template_factory"

get "/post/:id" do
    #indexModel = IndexModel.new
  
    indexView = TemplateFactory.instance.getTemplate("post.html")
    indexView.render()
  end