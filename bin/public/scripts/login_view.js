$(document).ready(function () {
    $('#loader-form').hide();

    $('#submit-button').click(function () {
        $('#inner-form').hide();
        $('#loader-form').show();

        var email = $('#email-input').val();
        var password = $('#password-input').val();

        // TODO: валидация        

        TeamLeadWebService.instance.mailLogin(email, password).then(function (res) {
            console.log(res);
            if (res.code == 0) {
                Cookies.set('sessionId', res.sessionId);                
                window.location.replace("/");
            } else {
                // TODO: вывод ошибки
            }
        });
    });
});