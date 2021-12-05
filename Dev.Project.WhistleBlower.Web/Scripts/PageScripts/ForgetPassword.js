$(document).ready(function () {
    onload();
});
function validate(event) {
    event.preventDefault();
    if (!Validation()) {


    } else {
        grecaptcha.execute();
        Execute();
    }
}
function onload() {
    var element = document.getElementById('btnRequest');
    element.onclick = validate;
}
function Validation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtemailAddress'))) {
        flag = false;
    }
    if (!ValidateEmail($('#txtemailAddress'))) {
        flag = false;
    }

    if (flag) {
        flag = ValidateUser();
    }
    return flag;
}
function Confirmation() {
    Execute();
}
function ValidateUser() {
    var isValidUser = false;
    var email = $('#txtemailAddress').val()

    $.ajax({
        url: '/api/ForgetPassword?UserEmail=' + email,
        cache: false,
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,

        success: function (response) {
            if (response != null && response.Message != "Email not found") {
                isValidUser = true;
            }
            else {
                isValidUser = false;
                alert(response.Message);
            }

        },
        error: function (response) {
            isValidUser = false;
            alert(response)
        },
        failure: function (response) {
            isValidUser = false;

        },
        complete: function () {

        }
    })

    return isValidUser;


}

function Execute() {

    var uidVal = "";
    var email = $('#txtemailAddress').val();
    var psw = "";

    var userData =
    {
        "UserID": uidVal, "Email": email, "Password": psw
    }

    $.ajax({
        url: '/api/ForgetPassword',
        method: 'POST',
        data: JSON.stringify(userData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        success: function (response) {
            if (response != "") {
                showSuccessMessage("Password reset link send successfully, you will receive email to update your password.");
            }
        },
        error: function (response) {
            alert(response.responseText);
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });

}

function Redirect() {
    //window.location.href = "/Home.aspx";
    window.location.href = "/";
}