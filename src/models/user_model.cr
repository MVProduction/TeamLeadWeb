require "./user_info_data"

# Модель для работы с пользователями
class UserModel
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