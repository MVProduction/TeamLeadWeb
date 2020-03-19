require "water"

class IndexView
    def initialize        
    end

    def create
        Water::Page.new do
            doctype
            html {
                body {
                    div "TeamLead"
                }
            }
        end
    end
end