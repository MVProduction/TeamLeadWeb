require "./models/user_info_data"

# сервис для работы с пользователями
class UserService
    # Экземпляр
    @@instance = UserService.new

    # Возвращает экземпляр
    def self.instance
        @@instance
    end

    # Возвращает информацию пользователя из cookie
    # Или nil если пользователь не найден
    def getUserInfoFromCookie(env : HTTP::Server::Context) : UserInfoData?
        sessionId = env.request.cookies["sessionId"]?
        if sessionId && !sessionId.value.empty?
          sessionIdValue = sessionId.value
          return UserInfoData.new("Grabli66")
        end
        nil
    end
end