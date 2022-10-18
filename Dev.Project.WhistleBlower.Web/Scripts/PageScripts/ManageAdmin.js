
$(document).ready(function () {


    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        loadManageAdminLanguageDetails()

    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});

function getAdminCount() {
    $.ajax({
        url: '/api/RegisteredUsers?adminOnly=true',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null) {
                showLmitationPerPLan(response.objAdminCount);
                disbaleManageAdminforNonSuperAdmin(response.isSuperAdmin)
                //showAdminUsers(response.objRegUser);
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
function disbaleManageAdminforNonSuperAdmin(isValue) {
    if (isValue == 1) {
        $('#ulclsExpMngAdminAccount').show();
    }
    else
        $('#ulclsExpMngAdminAccount').hide();

}
function showLmitationPerPLan(adminCount) {

    var planCode = $('#hdnSusPlanCode').val();
    var returnStr = "";

    $.ajax({
        url: '/api/SubscriptionPlans?id=' + planCode + '',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null) {

                String.format = function () {
                    var s = arguments[0];
                    for (var i = 0; i < arguments.length - 1; i++) {
                        var reg = new RegExp("\\{" + i + "\\}", "gm");
                        s = s.replace(reg, arguments[i + 1]);
                    }

                    return s;
                }

                var link = String.format($('#lblshowLimit').text(),
                    adminCount, response.AdminSeatCount);
                returnStr = link;//"You have already {" + adminCount + "} admin account. You can create maximum " + response.AdminSeatCount + "";
                $('#lblshowLimit').text(returnStr);
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
function loadManageAdminLanguageDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/ManageAdminLangMasters?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#formTitle').text(response[0].FormTitle);
                $('#formShortNote').text(response[0].TitleShortNotes);
                $('#ancclsExpMngAdminAccount').text(response[0].clsExpMngAdminAccount);
                $('#ancclsExpMngStatusCode').text(response[0].clsExpMngStatusCode);
                $('#ancclsExpVwSubsHistroy').text(response[0].clsExpVwSubsHistroy);
                $('#ancclsExpVwPolicyDocuments').text(response[0].clsExpVwPolicyDocuments);
                $('#ancclsExpManageLables').text(response[0].clsExpManageLables);
                $('#lblshowLimit').text(response[0].lblAdminCount);
                //$('#ancclsExpVwSubsHistroy').text(response[0].clsExpVwSubsHistroy);
                getAdminCount();
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


