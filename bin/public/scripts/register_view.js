$(document).ready(function () {
    $('#loader-form').hide();

    $('#submit-button').click(function () {
        // $('#inner-form').hide();
        // $('#loader-form').show();

        var email = $('#email-input').val();
        var password = $('#password-input').val();
        var passwordConfirm = $('#password-confirm-input').val();
        
        console.log(email);
        console.log(password);
        console.log(passwordConfirm);

        // TODO: валидация
        if (password != passwordConfirm) {
            return;
        }        

        console.log("VALID");

        TeamLeadWebService.instance.registerByMail(email, password).then(function (res) {
            console.log(res);
            if (res.code == 0) {
                //window.location.replace("/");
            } else {
                // TODO: вывод ошибки
            }
        });
    });
});