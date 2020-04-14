/** Сервис для работы с API сайта */
class TeamLeadWebService {
    /// Экземпляр
    static instance = new TeamLeadWebService();

    /// Задержка перед отправкой
    delay = 1000;

    /**
     * Осуществляет вход с помощью электронного адреса и пароля
     * email:string - электронный адрес
     * password:string - пароль     
     * return code:int - код ответа
     */
    /**
     * Осуществляет вход с помощью электронного адреса и пароля
     * @param {string} email - электронный адрес
     * @param {int} password - пароль
     * @return {int} - код ответа
     */
    mailLogin(email, password) {
        var del = this.delay;
        return new Promise(function (resolve, reject) {
            setTimeout(function () {
                console.log(email);
                console.log(password);

                $.ajax({
                    type: "POST",
                    url: "/auth/loginByMail",
                    data: JSON.stringify({
                        'login': email,
                        'password': password
                    }),
                    contentType: "application/json; charset=utf-8",
                    success: function (res) {
                        resolve({
                            code: res.code,
                            sessionId: res.sessionId
                        });
                    },
                    dataType: 'json'
                });
            }, del);
        });
    }

    /**
     * Регистрирует пользователя по электронной почте и паролю
     * @param {string} email 
     * @param {string} password 
     */
    registerByMail(email, password) {
        console.log("registerByMail");
        var del = this.delay;
        return new Promise(function (resolve, reject) {
            setTimeout(function () {                
                console.log(email);
                console.log(password);

                $.ajax({
                    type: "POST",
                    url: "/auth/sendRegisterLink",
                    data: JSON.stringify({
                        'login': email,
                        'password': password
                    }),
                    contentType: "application/json; charset=utf-8",
                    success: function (res) {
                        resolve({
                            code: res.code
                        });
                    },
                    dataType: 'json'
                });
            }, del);
        });
    }
}