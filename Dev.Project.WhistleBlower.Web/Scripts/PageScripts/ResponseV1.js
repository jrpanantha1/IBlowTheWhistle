$(document).ready(function () {
    debugger;
    if (localStorage.getItem('accessToken') != null) {
        loadLanguageDetails();
        getResponseHistory();
        getIncCaseDocuments();
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    menuEnableDisable();//ref Utility.js
    getResponseBannerDetails();

    jQuery('[data-toggle="tooltip"]').tooltip();

    if (isAdmin()) {
        $('#ancSaveChatInfotoCaseMngt').show();
    }
    else {
        $('#ancSaveChatInfotoCaseMngt').hide();
    }

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

        resCompanyLogo = items[i].companyLogo != null ? items[i].companyLogo : "/assets/images/LargeAvatar.png";

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
            chatHtml = chatHtml + '<div class="no-avatar avatar-sm"  >';
            chatHtml = chatHtml + '<img class="companyavatarResponse avatar ignoreforPDF" src="#"  style="height: 50px; width: 50px; align - content: center;"/>';
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
function uploadIncidentDocumentsinResponse() {

    var iurn = getUrlVars()["iURN"];;

    var data = new FormData();
    jQuery.each(jQuery('#FileAttachmentDetails')[0].files, function (i, file) {
        data.append('file-' + i, file);
    });

    $.ajax({
        type: "POST",
        url: '/api/FileUploader?iURN=' + iurn + '&IncDoc=true',
        enctype: 'multipart/form-data',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: false,
        processData: false,
        cache: false,
        data: data,
        success: function (data, textStatus, xhr) {
            $("#FileAttachmentDetails").val(null);
            getIncCaseDocuments();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });


}

function getIncCaseDocuments() {
    var iurn = getUrlVars()["iURN"];

    $.ajax({
        url: '/api/FileUploader?IURN=' + iurn + '&IncDoc=true',
        method: 'GET',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                var caseDocHtml = "";
                $('#divCaseDocuments').empty();

                var arrFile = response.split(';');

                //caseDocHtml = "<ul class='list - group list - group - flush'>";
                caseDocHtml = " <ol class='CaseDocfa-ul'>";

                for (var i = 0; i < arrFile.length; i++) {
                    var dRow = i + 1;
                    if (arrFile[i] != null && arrFile[i] != "") {

                        var last = arrFile[i].substring(arrFile[i].lastIndexOf("/") + 1, arrFile[i].length);

                        caseDocHtml += "<a target='_blank' href='" + arrFile[i] + "'><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dRow + " - " + last + "<i sValue='" + arrFile[i] + "' id='icon-trash-2' style='float:right;padding:5px;display:none;' class='icon-trash-2 mx-2'></i></li></a>";
                    }
                }
                caseDocHtml += "</ol >";

            }
            $('#divCaseDocuments').append(caseDocHtml);

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}
var anonymousText = "";
function loadLanguageDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
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
function getResponseBannerDetails() {
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
                var tarURL = "https://apps.iblowthewhistle.com?" + response[0].CompanyValue;
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
$(document).ready(function () {
    $(document).on('click', '#icon-trash-2',
        function () {

            //as per jordan #101 disbale this for now later we enable if required 05/Feb/2022
            return;

            var listValue = $(this).parent().parent().attr('href');
            if (confirm("Are you sure want to delete?")) {
                //alert(listValue);

                $.ajax({
                    url: '/api/FileUploader?delfilePath=' + listValue,
                    method: 'DELETE',
                    async: false,
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
                    },
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        if (response != null && response != "") {
                            //alert(response);
                            getIncCaseDocuments();
                        }
                    },
                    error: function (response) {

                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            }

            return false;
        });
});


function exportToPDF() {
    var doc = new jsPDF();  //create jsPDF object

    var divContents = $("#chartDiv").html();
    var imgSRC = $('.ignoreforPDF img').attr('src');

    var a = [];
    var imagesArray = $(divContents).find("img").each(function (index) {
        a[index] = $(this).html();
    });
    for (var i = 0; i < imagesArray.length; i++) {

        var find = imagesArray[i].currentSrc;
        find = find.substring(find.indexOf("/I"));
        //var find = ffind;//"/IBTWImages/4e2162b8-51f5-41fa-8eed-f0a4569bcca5/CompanyLogo.png";
        var re = new RegExp(find, 'g');

        divContents = divContents.replace(re, '#');
    }





    doc.fromHTML(divContents, // page element which you want to print as PDF
        15,
        15,
        {
            'width': 170  //set width
        },
        function (a) {


            var today = new Date();
            var tDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

            doc.save("ChatInfo - " + tDate + ".pdf"); // save file name as HTML2PDF.pdf
        });



}

function saveChatInfotoCaseMngt() {
    var doc = new jsPDF();  //create jsPDF object
    doc.fromHTML(document.getElementById("chartDiv"), // page element which you want to print as PDF
        15,
        15,
        {
            'width': 170  //set width
        },
        function (a) {


            //var today = new Date();
            //var tDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

            //var newName = "ChatInfo" + tDate + ".pdf";


            var blob = doc.output('blob');
            var formData = new FormData();
            //formData.append('pdf', blob);
            formData.append('pdf', blob);
            uploadChatInfotoCaseTracking(formData);

        });
}
function uploadChatInfotoCaseTracking(ffdata) {
    var iurn = getUrlVars()["iURN"];

    $.ajax({
        type: "POST",
        url: '/api/FileUploader?iURN=' + iurn,
        enctype: 'multipart/form-data',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: false,
        processData: false,
        cache: false,
        data: ffdata,
        success: function (data, textStatus, xhr) {
            updateCaseInformationOnStatusChange();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });
}

function getChatFileName() {

    var returnName;
    let date_ob = new Date();

    // adjust 0 before single digit date
    let date = ("0" + date_ob.getDate()).slice(-2);

    // current month
    let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);

    // current year
    let year = date_ob.getFullYear();

    // current hours
    let hours = date_ob.getHours();

    // current minutes
    let minutes = date_ob.getMinutes();

    // current seconds
    let seconds = date_ob.getSeconds();

    // prints date & time in YYYY-MM-DD HH:MM:SS format
    return returnName = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
}
function updateCaseInformationOnStatusChange() {

    var dd = getChatFileName();

    var loggedUser = $('#hdnLoggedUserName').val().trim();
    var textFormation = "Chat info uploaded by {" + loggedUser + "} File Name: Chat History - " + dd
    var iurn = getUrlVars()["iURN"];


    var dataResponse = {
        "CaseInformation": textFormation,
        "IURN": iurn
    };

    $.ajax({
        url: '/api/CaseManagements',
        method: 'POST',
        data: JSON.stringify(dataResponse),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                showSuccessMessage("Chat information has been successfully saved into Case Tracking.");
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


