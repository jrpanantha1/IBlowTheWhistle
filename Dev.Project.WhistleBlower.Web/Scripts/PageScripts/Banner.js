$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        getBannerDetails();
        loadBannerLanguageDetails();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});

function getBannerDetails() {
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
                    var tarURL = "https://apps.iblowthewhistle.com/Pages/Default.aspx?" + response[0].CompanyKey + "/ib" + response[0].CompanyValue;
                    //copy to clipboard
                    //var bannerValue = "<a target='_blank' href='" + tarURL + "'><img class='imgTopBanner' src='/assets/images/WhistleDefaultTopBanner.PNG' alt='horizontal banner' /></a>";
                    var bannerValue = tarURL;//"<a target='_blank' href='" + tarURL + "'></a>";
                    $('#txtBannerText').val(bannerValue);

                    $('.ancImgTopBanner').attr("href", tarURL);

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
function copyBannerLink() {
    var copyText = document.getElementById("txtBannerText");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = "Copied";
}

function loadBannerLanguageDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/BannerLangMasters?langID=' + Number(lanCode),
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
                $('#spanCompanyURL').text(response[0].lblCompanyURl);
                $('#h1QRCode').text(response[0].lblQRTitle);
                $('#pQRDesc').text(response[0].lblQRShortNotes);
                $('#btnGenerateQR').text(response[0].btnGenerateQRCode);
                $('#btnSaveasImage').text(response[0].btnSaveasImage);
                
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