
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        loadMyAccountLanguageDetails();
        getCompanyDetails();
        GetSubscriptionEndDate();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
});


function getCompanyDetails() {
    $.ajax({
        url: '/api/CompanyProfile/1',
        method: 'GET',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                if (localStorage.getItem("AcctType") == "Admin") {
                    if (response[0].CompanyTopBanner != null && response[0].CompanyTopBanner != "") {
                        $('.imgTopBanner').attr("src", response[0].CompanyTopBanner);
                    }
                    else {
                        $('.imgTopBanner').attr("src", "/assets/images/WhistleDefaultTopBanner.PNG");
                    }
                    if (response[0].CompanyLogo != null && response[0].CompanyLogo != "") {
                        $('.comavatar').attr("src", response[0].CompanyLogo);
                    }
                    else {
                        $('.comavatar').attr("src", "/assets/images/LargeAvatar.png");
                    }
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

function updateCompanyProfile() {

    var txtAltURL = $('#txtBannerText').val();
    var companyData =
    {
        "CompanyLogo": ppBase64,
        "CompanyTopBanner": cbBase64,
        "TopBannerAlternateURL": txtAltURL
    }

    $.ajax({
        url: '/api/CompanyMasters',
        method: 'POST',
        data: JSON.stringify(companyData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response != "") {
                $('#defualtComLogo').hide();
                $('#customizedLogo').show();
                $('.companyavatar').attr("src", response);
            }

            if (ppBase64 != "") {
                showSuccessMessage("Profile picture updated successfully.");
                ppBase64 = "";

            }
            else {

                showSuccessMessage("Top banner updated successfully.");
                cbBase64 = "";
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

function updatePrefferances() {
    var preferredZone = $('#eventsCalTimezone').text();

    var ZoneuserData =
    {
        "PreferredTimeZone": preferredZone
    }

    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'PUT',
        data: JSON.stringify(ZoneuserData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {
                showSuccessMessage("Preferred time zone updated successfully.");
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


var ppBase64 = "";
var cbBase64 = "";
function readFile(file, onLoadCallback) {
    var fSize = (file.size) / 1024;
    if (fSize < 600) {
        var reader = new FileReader();
        reader.onload = onLoadCallback;
        reader.readAsDataURL(file);
    } else {
        $('.msgBox').text("Photo size max 600kb")
        $('.msgBox').show(500);

        return false;
    }
}
function readBannerFile(file, onLoadCallback) {
    var fSize = (file.size) / 1024;
    if (fSize < 600) {
        var reader = new FileReader();
        reader.onload = onLoadCallback;
        reader.readAsDataURL(file);
    } else {
        $('.msgBox').text("Photo size max 600kb")
        $('.msgBox').show(500);

        return false;
    }
}


function GetSubscriptionEndDate() {

    $.ajax({
        url: '/api/SubscriptionHistroys',
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
                var endDate = new Date(items[0].ValidTo).toLocaleString();
                $('#lblEndDate').text($('#lblEndDate').text() + " " + endDate);
            }
        },
        error: function (response) {
            if (response.responseText.indexOf("Authorization has been denied for this request") != -1) {
                window.location.href = "/Pages/Login.aspx";
            }
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function loadMyAccountLanguageDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/MyAccountLangMasters?langID=' + Number(lanCode),
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
                $('#ancclsExpYourAvatar').text(response[0].clsExpYourAvatar);
                $('#ancclsExpTopBanner').text(response[0].clsExpTopBanner);
                $('#ancclsExpPreffLanguage').text(response[0].clsExpPreffLanguage);
                $('#ancclsExpPreffTimeZone').text(response[0].clsExpPreffTimeZone);
                $('#ancclsExpResetPassword').text(response[0].clsExpResetPassword);
                $('#lblEndDate').text(response[0].lblSubEndDate);
                $('#lblSelectPrifile').text(response[0].btnSelectPicture);
                $('#btnUpdateAccount').val(response[0].btnUpdatePicture);
                $('#lblSelectBanner').text(response[0].btnSelectPicture);
                $('#btnUpdateTopBanner').val(response[0].btnUpdateBanner);
                $('#lblSelectTimeZone').text(response[0].lblTimeSelector);
                $('#spanCompanyURL').text(response[0].topBannerAltURL);
                //$('#successMessage').text(response[0].SuccessMessage);
                //$('#txtMessage').attr("placeholder", response[0].Leavecomment);
                //anonymousText = response[0].AnonymousUser;
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