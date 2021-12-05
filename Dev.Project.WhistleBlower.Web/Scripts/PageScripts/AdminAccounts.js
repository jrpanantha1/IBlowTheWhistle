
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        GetAdminAccounts();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});

var JsonAdminAccObj = [];
function GetAdminAccounts() {

    var lanCode = 1;
    if (localStorage.getItem("iBlowLanguage") != null) {
        lanCode = localStorage.getItem("iBlowLanguage").toString();
    }
    JsonAdminAccObj = [];


    $.ajax({
        url: '/api/RegisteredUsers?AcctType=Admin',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                var items = response;
                for (var i = 0; i < items.length; i++) {

                    JsonAdminAccObj.push({
                        "rID": i + 1,
                        "rRegUserID": items[i].RegUserID,
                        "rEmail": items[i].Email,
                        "rFirstName": items[i].FirstName,
                        "rLastName": items[i].LastName,
                        "rFullName": items[i].FullName,
                        "risPrimary": items[i].IsPrimaryAcc != null && items[i].IsPrimaryAcc != "" ? items[i].IsPrimaryAcc : "false"
                    });
                }

                $('#tableAdminAccounts').DataTable().clear();
                $('#tableAdminAccounts').DataTable().destroy();

                $('#tableAdminAccounts').DataTable({
                    "data": JsonAdminAccObj,
                    "bDestroy": true,
                    "bProcessing": true,
                    select: {
                        style: 'single'
                    },
                    language: {
                        paginate: {
                            next: '&#8594;', // or '→'
                            previous: '&#8592;' // or '←' 
                        }
                    },
                    "bProcessing": true,
                    "columnDefs": [
                        { targets: [0, 1, 2, 3, 4, 5], visible: true },
                        { targets: '_all', visible: false }
                    ],
                    "iDisplayLength": 10,
                    "aoColumns": [
                        { "data": "rID" },
                        { "data": "rFirstName" },
                        { "data": "rLastName" },
                        { "data": "rFullName" },
                        { "data": "rEmail" },
                        { "data": "risPrimary" },
                        { "data": "rRegUserID" }
                    ]
                });

                // $('#tableAdminAccounts').DataTable().draw();

                var table = $('#tableAdminAccounts').DataTable();
                $('#tableAdminAccounts tbody').on('click', 'tr', function () {

                    if ($(this).hasClass('selected')) {
                        $(this).removeClass('selected');
                    }
                    else {
                        table.$('tr.selected').removeClass('selected');
                        $(this).addClass('selected');
                    }

                    var selectedData = table.rows('.selected').data();
                    if (selectedData != null) {


                        //alert(selectedData[0].rPreAction);
                        $('#txtEmail').val(selectedData[0].rEmail);
                        $('#txtRegID').val(selectedData[0].rRegUserID);
                        $('#txtFirstName').val(selectedData[0].rFirstName);
                        $('#txtLastName').val(selectedData[0].rLastName);
                        $('#txtFullName').val(selectedData[0].rFullName);

                        $('#txtEmail').attr("disabled", "disabled");
                        $('#btnAddNew').hide();
                        $('#btnSubmit').show();
                    }
                });

            }
        },
        error: function (response) {
            alert(response.responseText);
            if (response.responseText.indexOf("Authorization has been denied for this request") != -1) {
                window.location.href = "/Pages/Login.aspx";
            }
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function updateAdminAccValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtPassword'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtConfirmPassword'))) {
        flag = false;
    }
    else {
        if (!ConfirmPassword($('#txtPassword'), $('#txtConfirmPassword'))) {
            flag = false;
        }
    }

    return flag;
}
function updateAdminAccounts() {
    var sPassword = $('#txtPassword').val();
    var sEmail = $('#txtEmail').val();

    var RegUserData = {
        "firstName": $('#txtFirstName').val(),
        "fullName": $('#txtFullName').val(),
        "lastName": $('#txtLastName').val(),
        "Email": $('#txtEmail').val(),
        "password": $('#txtPassword').val()
    };

    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'PUT',
        data: JSON.stringify(RegUserData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response == "updated successfully.") {
                showSuccessMessage("user updated successfully.");
                ClearUpdateForm();
                GetAdminAccounts();
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
function shownewForm() {
    $('#txtFirstName').val("");
    $('#txtFirstName').removeClass('error');
    $('#txtLastName').val("");
    $('#txtLastName').removeClass('error');
    $('#txtEmail').val("");
    $('#txtEmail').removeClass('error');
    $('#txtPassword').val("");
    $('#txtPassword').removeClass('error');
    $('#txtConfirmPassword').val("");
    $('#txtConfirmPassword').removeClass('error');
    $('#txtFullName').val("");
    $('#txtFullName').removeClass('error');
    $('#txtEmail').removeAttr("disabled");
    $('#btnAddNew').show();
    $('#btnAddNew').removeClass("d-none")
    $('#btnSubmit').hide();


}
function ClearUpdateForm() {
    $('#txtFirstName').val("");
    $('#txtLastName').val("");
    $('#txtEmail').val("");
    $('#txtPassword').val("");
    $('#txtConfirmPassword').val("");
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

    if ($('#txtPassword').val() != $('#txtConfirmPassword').val()) {
        flag = false;
        $('#txtPassword').addClass('error');
        $('#txtConfirmPassword').addClass('error');
    }
    else {
        $('#txtPassword').removeClass('error');
        $('#txtConfirmPassword').removeClass('error');
    }
    return flag;
}
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
                shownewForm();
                GetAdminAccounts();
            }
            if (response != null && response != "Success") {
                $('#divWarning').show();
                $('#spanwarningText').text(response);
            }
        },
        error: function (response) {
            alert(response.responseText);
            shownewForm();
        },
        failure: function (response) {
            alert(response.responseText);
            shownewForm();
        }
    });

}