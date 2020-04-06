$(document).ready(function () {
    $('#loader-form').hide();

    $('#submit-button').click(function () {
        $('#inner-form').hide();
        $('#loader-form').show();

        $.ajax({
            type: "POST",
            url: "/auth/mail_login",
            data: data,
            success: success,
            dataType: dataType
        });
    });
});