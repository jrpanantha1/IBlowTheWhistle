
$(document).ready(function () {

    //sessionStorage.clear();
    localStorage.removeItem("accessToken");
    onload();
});

function onSubmit(token) {
    authendicate();
}
function validate(event) {
    event.preventDefault();
    if (!loginValidation()) {

    } else {
        grecaptcha.execute();
    }
}
function onload() {
    var element = document.getElementById('btnSignin');
    element.onclick = validate;
}
function loginValidation() {
    var flag = true;
    $('#lblError').hide();
    if (!GetTextBoxEmptyValidation($('#txtemailAddress'))) {
        flag = false;
    }

    if (!ValidateEmail($('#txtemailAddress'))) {
        flag = false;
    }

    if (!GetTextBoxEmptyValidation($('#txtPassword'))) {
        flag = false;
    }

   
    return flag;
}



function authendicate() {


    var email = $('#txtemailAddress').val();
    var psw = $('#txtPassword').val();

    var userData = {
        username: email,
        password: psw,
        grant_type: 'password',
    }

    $.ajax({

        url: '/token',
        method: "POST",
        data: userData,//JSON.stringify(userData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,

        success: function (response) {

            //sessionStorage.setItem("accessToken", response.access_token);
            localStorage.setItem("accessToken", response.access_token);
            //AddAudit();
            getUserDetails();
            window.location.href = "/Pages/ViewIncidents.aspx";

        },
        error: function (response) {

            if (response.responseText == "{\"error\":\"Login Error\"}") {
                $('#lblError').text("User name or Password incorrect");
            } else if (response.responseText == "{\"error\":\"User not found\"}") {
                $('#lblError').text("User not found");
            }
            $('#lblError').show();
            onload();
            grecaptcha.reset();
        },
        failure: function (response) {
            grecaptcha.reset();

        },
        complete: function () {
            grecaptcha.reset();
        }
    })


}

function getUserDetails() {
    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        success: function (response) {
            if (response != "") {
                localStorage.setItem("AcctType", response[0].AcctType);
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}




