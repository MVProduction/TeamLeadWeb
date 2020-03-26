require "kemal"
require "crinja"
require "./models/post_list_model"

env = Crinja.new
env.loader = Crinja::Loader::FileSystemLoader.new("views/")

get "/" do
  postModel = PostListModel.new

  indexView = env.get_template("index.html")
  indexView.render(
    { 
      postList: postModel.getRecentPosts(20, 200)      
    })
end

# logging false
  
Kemal.run 8080