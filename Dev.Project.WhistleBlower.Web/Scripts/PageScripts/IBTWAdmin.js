
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
        getCompanyLists();
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    $(".comanyListDDL").change(function () {
        var selValue = $('#ddlCompanyList').val();
        getCompanyKeyLink(selValue);
    });
});

function createCompanyAdminUsers() {

    var objNewUser = {
        "firstName": $('#txtFirstName').val(),
        "fullName": $('#txtFullName').val(),
        "lastName": $('#txtLastName').val(),
        "Email": $('#txtEmail').val(),
        "CompanyID": $('#ddlCompanyList').val()
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
            if (response != null && response != "") {
                showSuccessMessage("Account created successfully.");
                $('#divPassword').show();
                $('#txtPassword').val(response);
                clearIBTWAdminControls();
            }
        },
        error: function (response) {
            alert(response.responseText);
            clearIBTWAdminControls();
            $('#divPassword').hide();
        },
        failure: function (response) {
            alert(response.responseText);
            clearIBTWAdminControls();
            $('#divPassword').hide();
        }
    });

}
function clearIBTWAdminControls() {
    $('#txtFirstName').val("");
    $('#txtLastName').val("");
    $('#txtFullName').val("");

}
function getCompanyLists() {

    $.ajax({
        url: '/api/CompanyMasters',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {
                var comLength = response.length;
                $('#ddlCompanyList').empty();

                for (var i = 0; i < comLength; i++) {
                    var opt = $("<option>").val(response[i].CURN).text(response[i].CompanyName);
                    $('#ddlCompanyList').append(opt);
                }

            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });

}
function newJoinCompanyAdminValidation() {
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

    return flag;
}
function copyPassword() {
    var copyText = document.getElementById("txtPassword");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = "Copied";

}

function getCompanyKeyLink(ddlValue) {

    $.ajax({
        url: '/api/CompanyMasters?companyID=' + ddlValue,
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {
                $("#txtCompanyURLLink").val("");
                var tarURL = "https://iblowthewhistle.com/Pages/Default.aspx?" + response.CompanyKey + "/ib" + response.CompanyValue;
                $("#txtCompanyURLLink").val(tarURL);

            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}
function copyCompanyLink() {
    var copyText = document.getElementById("txtCompanyURLLink");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPassCom");
    tooltip.innerHTML = "Copied";

}

