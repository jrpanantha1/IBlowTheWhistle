
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    getCompanyProfile();
    getUserProfileDetails();
    loadAvatarMenuLanguage();
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
                var tarURL = "https://apps.iblowthewhistle.com?" + response.CompanyValue;
                $("#txtQrCode").val(tarURL);

                //if (localStorage.getItem("AcctType") != "Admin" || response.SubscriptionPlan == 1) {
                if (localStorage.getItem("AcctType") != "Admin") {
                    $('.AdminAccountOnlymenu').hide();
                }
                //update hidden key for feature ref
                $('#hdnSusPlanCode').val(response.SubscriptionPlan != null ? response.SubscriptionPlan : 1);

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
                var llcode = response[0].PreferredLanguage != null ? response[0].PreferredLanguage : "1";
                $("#hdnPreferredLang").val(llcode);
                localStorage.setItem("iBlowLanguage", llcode);
                $("#hdnPreferredZone").val(response[0].PreferredTimeZone);
                $("#dropdownFilter").text(response[0].PreferredFilter);
                $("#hdnPreferredFilter").val(response[0].PreferredFilter);
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function loadAvatarMenuLanguage() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/AvatarMenuLanguages?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#ancMenuAccount').append(response[0].menu1Account);
                $('#ancMenuCaptureOwn').append(response[0].menu2CaptureOwnInc);
                $('#ancMenuBanners').append(response[0].menu3Banner);
                $('#ancMenuReports').append(response[0].menu4Dashboard);
                $('#ancMenuAdmin').append(response[0].menu5Admin);
                $('#btnsignOut').append(response[0].menu6SignOut);
                $('#ancMenuHelp').append(response[0].menu7Help);
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