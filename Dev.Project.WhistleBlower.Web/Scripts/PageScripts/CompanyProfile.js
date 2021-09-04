
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    getCompanyProfile();
    getUserProfileDetails();

});

function getCompanyProfile() {
    $.ajax({
        url: '/api/CompanyProfile',
        method: 'GET',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {

                if (response.CompanyLogo != null && response.CompanyLogo != "") {
                    $('#divNoavatar').removeClass('no-avatar');
                    $('.companyavatar').attr("src", response.CompanyLogo);
                    $('.comavatar').attr("src", response.CompanyLogo);
                    $('#defualtComLogo').hide();
                    $('#customizedLogo').show();
                }
                if (response.CompanyName != null && response.CompanyName != "") {
                    $(".spanCompanyNameIcon").text(response.CompanyName);
                    $("#h1CompanyName").text(response.CompanyName);// display in View Incident and Reoprt Incodent top 
                }
                //update for QR code in banners page
                var tarURL = "https://iblowthewhistle.com/Pages/Default.aspx?" + response.CompanyKey + "/ib" + response.CompanyValue;
                $("#txtQrCode").val(tarURL);

                //if (localStorage.getItem("AcctType") != "Admin" || response.SubscriptionPlan == 1) {
                if (localStorage.getItem("AcctType") != "Admin") {
                    $('.AdminAccountOnlymenu').hide();
                }
                //update hidden key for feature ref
                $('#hdnSusPlanCode').val(response.SubscriptionPlan);

            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function getUserProfileDetails() {
    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        success: function (response) {
            if (response != "") {
                var fName = response[0].FirstName != null && response[0].FirstName != "" ? response[0].FirstName : "";
                var lName = response[0].LastName != null && response[0].LastName != "" ? response[0].LastName : "";
                var uName = fName + " " + lName;
                $(".usernametxt").text(uName);
                $("#hdnLoggedUserName").val(uName);
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}