
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
        getCompanyDetails();
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
                        $('.imgTopBanner').attr("src", "/assets/images/Whistle_728x90_Internalbanner.PNG");
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

    var companyData =
    {
        "CompanyLogo": ppBase64,
        "CompanyTopBanner": cbBase64
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
                $('.companyavatar').attr("src", response)

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