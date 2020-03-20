require "kemal"
require "crinja"
require "./models/post_list_model"

env = Crinja.new
env.loader = Crinja::Loader::FileSystemLoader.new("views/")

get "/" do
  postModel = PostListModel.new
  
  indexView = env.get_template("index.j2")
  indexView.render({ "model" => postModel })
end

logging false
  
Kemal.run