require "kemal"
require "crinja"

env = Crinja.new
env.loader = Crinja::Loader::FileSystemLoader.new("views/")

indexView = env.get_template("index.j2")

get "/" do    
  indexView.render  
end

logging false
  
Kemal.run