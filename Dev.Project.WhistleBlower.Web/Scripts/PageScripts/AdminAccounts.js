
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
            if (response != "Unauthorized") {
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
                        { targets: [0, 1, 2, 3, 4, 5, 6, 7], visible: true },
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

                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = "<a data-toggle='tooltip' data-placement='top'  data-original-title='Select row to update' onclick='GetUsersDetails(this)'  href='javascript:;'><img src='/Images/viewIcon.png' /></a>";
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = "<a data-toggle='tooltip' data-placement='top'  data-original-title='Delete' onclick='deleteUID(this)'  href='javascript:;'><img src='/Images/deleteIcon.png' /></a>";
                                return ReturnHTML;
                            }
                        },
                        { "data": "rRegUserID" }
                    ]
                });

                // $('#tableAdminAccounts').DataTable().draw();

                var table = $('#tableAdminAccounts').DataTable();
                $('#tableAdminAccounts tbody').on('click', 'tr', function () {

                    //if ($(this).hasClass('selected')) {
                    //    $(this).removeClass('selected');
                    //}
                    //else {
                    //    table.$('tr.selected').removeClass('selected');
                    //    $(this).addClass('selected');
                    //}

                    //var selectedData = table.rows('.selected').data();
                    //if (selectedData != null) {


                    //    //alert(selectedData[0].rPreAction);
                    //    $('#txtEmail').val(selectedData[0].rEmail);
                    //    $('#txtRegID').val(selectedData[0].rRegUserID);
                    //    $('#txtFirstName').val(selectedData[0].rFirstName);
                    //    $('#txtLastName').val(selectedData[0].rLastName);
                    //    $('#txtFullName').val(selectedData[0].rFullName);

                    //    $('#txtEmail').attr("disabled", "disabled");
                    //    $('#btnAddNew').hide();
                    //    $('#btnSubmit').show();
                    //}
                });

                //$('#tableAdminAccounts').on("click", ".btnDelete", function () {


                //});

                jQuery('[data-toggle="tooltip"]').tooltip();
            }
            else {
                $('#btnCancel').hide();
                $('#btnback').show();
                alert(response);
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
function deleteUID(ele) {
    var dataRow = $('#tableAdminAccounts').DataTable().row($(ele).closest('tr')).data();
    if (dataRow.risPrimary == "false") {
        if (confirm("Are you sure?")) {
            deleteRegisterdUser(dataRow.rRegUserID);
        }
    }
    else {
        alert("Primary account cannot be deleted.");
    }

    return false;
}
function GetUsersDetails(ele) {
    var dataRow = $('#tableAdminAccounts').DataTable().row($(ele).closest('tr')).data();
    var table = $('#tableAdminAccounts').DataTable();
    //apply selected class     
    table.$('tr.selected').removeClass('selected');
    $(ele).closest('tr').addClass('selected');

    //$('#tableAdminAccounts').DataTable().removeClass('selected');
    //$('#tableAdminAccounts').DataTable().row($(ele).closest('tr')).addClass('selected');



    // var selectedData = table.rows('.selected').data();
    if (dataRow != null) {


        //alert(selectedData[0].rPreAction);
        $('#txtEmail').val(dataRow.rEmail);
        $('#txtRegID').val(dataRow.rRegUserID);
        $('#txtFirstName').val(dataRow.rFirstName);
        $('#txtLastName').val(dataRow.rLastName);
        $('#txtFullName').val(dataRow.rFullName);

        $('#txtEmail').attr("disabled", "disabled");
        $('#btnAddNew').hide();
        $('#btnSubmit').show();
    }


    //alert(dataRow.rRegUserID);
}
function deleteRegisterdUser(rUsergID) {

    $.ajax({
        url: '/api/RegisteredUsers?id=' + rUsergID,
        method: 'DELETE',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response == "Success") {
                showSuccessMessage("Record deleted successfully.");
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
function updateAdminAccValidation() {
    var flag = true;
    if (!GetTextBoxEmptyValidation($('#txtFirstName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtLastName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtFullName'))) {
        flag = false;
    }
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