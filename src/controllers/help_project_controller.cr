require "kemal"

require "../common/template_factory"

get "/help_project" do |env|
  userModel = UserModel.new

  helpView = TemplateFactory.instance.getTemplate("main/help_project_view.html")
  helpView.render({
    loginUser: userModel.getUserInfoFromCookie(env)
  })
end