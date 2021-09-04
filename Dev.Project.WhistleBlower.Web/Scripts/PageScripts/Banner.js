$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
        getBannerDetails();
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
                    var tarURL = "https://iblowthewhistle.com/Pages/Default.aspx?" + response[0].CompanyKey + "/ib" + response[0].CompanyValue;
                    //copy to clipboard
                    //var bannerValue = "<a target='_blank' href='" + tarURL + "'><img class='imgTopBanner' src='/assets/images/WhistleDefaultTopBanner.PNG' alt='horizontal banner' /></a>";
                    var bannerValue = "<a target='_blank' href='" + tarURL + "'></a>";
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