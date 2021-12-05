
$(document).ready(function () {

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






function reSetConfirmation() {

    var psw = $('#txtPassword').val();
    var uID = getUrlVars()["uid"];;

    var userUpdatePwdData =
    {
        "Password": psw,
        "RegUserID": uID
    }

    $.ajax({
        url: '/api/UpdatePassword',
        method: 'PUT',
        data: JSON.stringify(userUpdatePwdData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        success: function (response) {
            if (response != "") {
                showSuccessMessage("password updated successfully.");
                $('#txtPassword').val("");
                $('#txtRePassword').val("");
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