require "kemal"

require "../common/template_factory"
require "../services/user_service"

get "/help_project" do |env|
  userModel = UserService.new

  helpView = TemplateFactory.instance.getTemplate("main/help_project_view.html")
  helpView.render({
    loginUser: userModel.getUserInfoFromCookie(env)
  })
end