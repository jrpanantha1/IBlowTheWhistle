$(document).ready(function () {

    if (localStorage.getItem('accessToken') != null) {
        loadLanguageDetails();
        getResponseHistory();
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    menuEnableDisable();//ref Utility.js
    getBannerDetails();
});

function getResponseHistory() {
    var iurn = getUrlVars()["iURN"];
    $.ajax({
        url: '/api/AnonymousResponseHistories?strIURN=' + iurn,
        cache: false,
        type: "GET",
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            if (response != null && response != "") {

                var items = response;
                showHistroy(items);

            }
            else {

            }

        },
        error: function (response) {
            window.location.href = "/Pages/Login.aspx";

        },
        failure: function (response) {
        },
        complete: function () {

        }
    })
}

function showHistroy(items) {
    var chatHtml = "";
    var chatHtmlCompany = "";
    var resCompanyLogo = "";
    for (var i = 0; i < items.length; i++) {

        var resDate = new Date(items[i].ResponseDate).toLocaleString();
        var resMessage = items[i].Message != "" ? items[i].Message : "";
        var resCompanyName = items[i].companyName;
        resCompanyLogo = items[i].companyLogo;

        if (items[i].commentBy == "Anonymous User") {



            chatHtml = chatHtml + '<div class="comment mb-3" >';

            chatHtml = chatHtml + '<div class="row">';
            chatHtml = chatHtml + '<div class="col-auto">';
            chatHtml = chatHtml + '<!-- Avatar -->';
            chatHtml = chatHtml + '<div class="no-avatar avatar-sm bg-primary">';
            chatHtml = chatHtml + '<i class="icon-user"></i>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + ' </div>';
            chatHtml = chatHtml + '<div class="col ml-n2">';
            chatHtml = chatHtml + '<!-- Body -->';
            chatHtml = chatHtml + '<div class="comment-body">';
            chatHtml = chatHtml + ' <div class="row">';
            chatHtml = chatHtml + '<div class="col">';
            chatHtml = chatHtml + '<!-- Title -->';
            chatHtml = chatHtml + '<h6 class="mb-1">' + anonymousText + '';
            chatHtml = chatHtml + '</h6>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<div class="col-auto">';
            chatHtml = chatHtml + ' <!-- Time -->';
            chatHtml = chatHtml + ' <time class="small text-muted">' + resDate + '';
            chatHtml = chatHtml + '</time>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<!-- / .row -->';
            chatHtml = chatHtml + '<!-- Text -->';
            chatHtml = chatHtml + '<p class="comment-text">';
            chatHtml = chatHtml + '' + resMessage + '';

            chatHtml = chatHtml + '</p>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<!-- / .row -->';
            chatHtml = chatHtml + '</div>  <hr>';
        }
        else {


            chatHtml = chatHtml + '<div class="comment mb-3" >';

            chatHtml = chatHtml + '<div class="row">';
            chatHtml = chatHtml + '<div class="col-auto order-2">';
            chatHtml = chatHtml + '<!-- Avatar -->';
            chatHtml = chatHtml + '<div class="no-avatar avatar-sm">';
            chatHtml = chatHtml + '<img class="companyavatarResponse avatar" src="#" style="height: 50px; width: 50px; align - content: center;"/>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + ' </div>';
            chatHtml = chatHtml + '<div class="col mr-n2 order-1">';
            chatHtml = chatHtml + '<!-- Body -->';
            chatHtml = chatHtml + '<div class="comment-body">';
            chatHtml = chatHtml + ' <div class="row">';
            chatHtml = chatHtml + '<div class="col">';
            chatHtml = chatHtml + '<!-- Title -->';
            chatHtml = chatHtml + '<h6 class="mb-1">' + resCompanyName + '';
            chatHtml = chatHtml + '</h6>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<div class="col-auto">';
            chatHtml = chatHtml + ' <!-- Time -->';
            chatHtml = chatHtml + ' <time class="small text-muted">' + resDate + '';
            chatHtml = chatHtml + '</time>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<!-- / .row -->';
            chatHtml = chatHtml + '<!-- Text -->';
            chatHtml = chatHtml + '<p class="comment-text">';
            chatHtml = chatHtml + '' + resMessage + '';

            chatHtml = chatHtml + '</p>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '</div>';
            chatHtml = chatHtml + '<!-- / .row -->';
            chatHtml = chatHtml + '</div>  <hr>';
        }
    }

    $("#chartDiv").html(chatHtml);
    $('.companyavatarResponse').attr("src", resCompanyLogo);
}

function validateControl() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtMessage'))) {
        flag = false;

    }
    return flag;
}

function sendResponse() {

    if (!validateControl()) {
        return false;
    }
    var iurn = getUrlVars()["iURN"];
    var dataResponse = {
        "Message": $('#txtMessage').val(),
        "IURN": iurn
    };

    $.ajax({
        url: '/api/AnonymousResponseHistories',
        method: 'POST',
        data: JSON.stringify(dataResponse),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                var items = response;
                showSuccessMessage("Your response captured.");
                //$('#divSuccess').show();
                showHistroy(items);
                $('#txtMessage').val("");

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
var anonymousText = "";
function loadLanguageDetails() {


    var lanCode = 1;
    if (sessionStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/ResponseLanguages?langID=' + Number(lanCode),
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
                $('#btSend').text(response[0].Submit);
                $('#btnClose').text(response[0].Close);
                $('#successMessage').text(response[0].SuccessMessage);
                $('#txtMessage').attr("placeholder", response[0].Leavecomment);
                anonymousText = response[0].AnonymousUser;
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
                if (response[0].CompanyTopBanner != null && response[0].CompanyTopBanner != "") {
                    $('.imgTopBanner').attr("src", response[0].CompanyTopBanner);

                }
                else {
                    $('.imgTopBanner').attr("src", "/assets/images/WhistleDefaultTopBanner.PNG");
                }
                var tarURL = "https://iblowthewhistle.com/Pages/Home.aspx?" + response[0].CompanyKey + "/ib" + response[0].CompanyValue;
                $('.ancImgTopBanner').attr("href", tarURL);
                $('.topBanner').show();
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}