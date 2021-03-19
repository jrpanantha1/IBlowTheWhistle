
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});
function reSetValidation() {
    var flag = true;
    if (!GetTextBoxEmptyValidation($('#txtPassword'))) {
        flag = false;
    }

    if (!GetTextBoxEmptyValidation($('#txtRePassword'))) {
        flag = false;
    }

    if (GetTextBoxEmptyValidation($('#txtPassword')) && GetTextBoxEmptyValidation($('#txtRePassword'))) {
        if (!ConfirmPassword($('#txtPassword'), $('#txtRePassword'))) {
            flag = false;
        }
    }

    return flag;
}


function GetParameterfromUrl(name) {
    var url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}



function reSetConfirmation() {

    var psw = $('#txtPassword').val();

    var userData =
    {
        "Password": psw
    }

    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'POST',
        data: JSON.stringify(userData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {

                $("#myToast").toast({ delay: 3000 });
                $("#myToast").toast('show');
                $('#txtPassword').val("");
                $('#txtRePassword').val("");
                // alert(response);
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