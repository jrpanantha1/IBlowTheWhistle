$(document).ready(function () {
    getCompanyNumber();
});
function Validation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#CompanyURN'))) {
        flag = false;
    }

    return flag;
}
function validateCompanyKey() {

    var comValue = $('#CompanyURN').val();
    var comKey = "";


    var userData = {
        username: comKey,
        password: comValue,
        grant_type: 'password',
    }

    $.ajax({

        url: '/token',
        method: "POST",
        data: userData,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',

        success: function (response) {

            localStorage.setItem("accessToken", response.access_token);
            window.location.href = "/Pages/IncidentForm.aspx";

        },
        error: function (response) {

            if (response.responseText == "{\"error\":\"Login Error\"}") {
                alert('Complany ID is not Valid');
            } else if (response.responseText == "{\"error\":\"Invalid user company\"}") {
                alert('Complany ID is not Valid');
            }
            else {
                alert('Complany ID is not Valid/ Invalid User Name and Password');
            }
            window.location.href = "/Pages/Home.aspx";

        },
        failure: function (response) {


        },
        complete: function () {

        }
    })


}

function getCompanyNumber() {

    $.ajax({
        url: '/api/CompanyMasters/1',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != "") {
                $('#CompanyURN').val(response.CompanyValue);
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });

}