
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    getCompanyProfile();

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
                var tarURL = "https://iblowthewhistle.com/Pages/Home.aspx?" + response.CompanyKey + "/ib" + response.CompanyValue;
                $("#txtQrCode").val(tarURL);


                if (localStorage.getItem("AcctType") != "Admin" || response.SubscriptionPlan == 1) {
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