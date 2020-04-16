# Информация о пользователе
@[Crinja::Attributes]
class UserInfoData
    include Crinja::Object::Auto

    # Имя пользователя
    getter name : String

    # Конструктор
    def initialize(@name)        
    end
end