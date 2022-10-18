
$(document).ready(function () {


});
function AddNewExaminorValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtEmail'))) {
        flag = false;
    }

    return flag;
}

function addNewEmaminorDetails() {

    var stxtName = $('#txtName').val();
    var stxtEmail = $('#txtEmail').val();
    var stxtOrganisation = $('#txtOrganisation').val();
    var stxtRole = $('#txtRole').val();
    var stxtPhone = $('#txtPhone').val();

    var dataNewExaminor = {
        "Name": stxtName,
        "EmailAddress": stxtEmail,
        "Organisation": stxtOrganisation,
        "Role": stxtRole,
        "Phone": stxtPhone
    };

    $.ajax({
        url: '/api/AssesmentUsers',
        method: 'POST',
        data: JSON.stringify(dataNewExaminor),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "" && response == "Success") {
                window.location.href = "/Assessment/Pages/TakeAssesment.aspx";
                //showSuccessMessage("Status Code has been added successfully.");
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