/** Сервис для работы с API сайта */
class TeamLeadWebService {
    /// Экземпляр
    static instance = new TeamLeadWebService();

    /**
     * Осуществляет вход с помощью электронного адреса и пароля
     * email:string - электронный адрес
     * password:string - пароль
     * delay:int - задержка работы
     * return code:int - код ответа
     */
    mailLogin(email, password, delay = 1000) {
        return new Promise(function (resolve, reject) {
            setTimeout(function () {
                console.log(email);
                console.log(password);

                $.ajax({
                    type: "POST",
                    url: "/auth/mail_login",
                    data: JSON.stringify({
                        'login': email,
                        'password': password
                    }),
                    contentType: "application/json; charset=utf-8",
                    success: function (res) {
                        resolve(res.code);
                    },
                    dataType: 'json'
                });
            }, delay);
        });
    }
}