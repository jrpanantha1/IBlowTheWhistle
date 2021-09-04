
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
});


function createNewAdminUsers() {

    var objNewUser = {
        "firstName": $('#txtFirstName').val(),
        "fullName": $('#txtFullName').val(),
        "lastName": $('#txtLastName').val(),
        "Email": $('#txtEmail').val(),
        "password": $('#txtPassword').val()
    };


    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'POST',
        data: JSON.stringify(objNewUser),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response == "Success") {
                showSuccessMessage("Account created successfully.");
                clearControls();
            }
            if (response != null && response != "Success") {
                $('#divWarning').show();
                $('#spanwarningText').text(response);
            }
        },
        error: function (response) {
            alert(response.responseText);
            clearControls();
        },
        failure: function (response) {
            alert(response.responseText);
            clearControls();
        }
    });

}
function clearControls() {
    $('#txtFirstName').val("");
    $('#txtLastName').val("");
    $('#txtEmail').val("");
    $('#txtPassword').val("");
    $('#txtConPassword').val("");
    $('#txtFullName').val("");

}
function newJoinValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtFirstName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtLastName'))) {
        flag = false;
    }
    if (!ValidateEmail($('#txtEmail'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtPassword'))) {
        flag = false;
    }

    if ($('#txtPassword').val() != $('#txtConPassword').val()) {
        flag = false;
        $('#txtPassword').addClass('error');
        $('#txtConPassword').addClass('error');
    }
    else {
        $('#txtPassword').removeClass('error');
        $('#txtConPassword').removeClass('error');
    }
    return flag;
}