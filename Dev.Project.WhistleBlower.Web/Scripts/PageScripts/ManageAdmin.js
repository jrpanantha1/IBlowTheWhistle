
$(document).ready(function () {


    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        getAdminCount();
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
                returnStr = "You have already {" + adminCount + "} admin account. You can create maximum " + response.AdminSeatCount + "";
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



