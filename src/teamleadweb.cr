require "orion"
require "./views/index_view"

router TeamLeadWeb do    
    root do |context|
      view = IndexView.new
      context.response.puts view.create
    end      
  end
  
  TeamLeadWeb.listen(port: 8080)