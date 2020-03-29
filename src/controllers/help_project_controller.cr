require "kemal"

require "../common/template_factory"

get "/help_project" do |env|
  helpView = TemplateFactory.instance.getTemplate("help_project.html")
  helpView.render()
end