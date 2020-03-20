require "kemal"
require "crinja"

env = Crinja.new
env.loader = Crinja::Loader::FileSystemLoader.new("views/")

indexView = env.get_template("index.j2")

get "/" do 
  posts = Array(String).new
  posts << "Ищу кусок говна"
  posts << "Ищу стартап что бы найти кусок стартапа"
  indexView.render({ "posts" => posts })
end

logging false
  
Kemal.run