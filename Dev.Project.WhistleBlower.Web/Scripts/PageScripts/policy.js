
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
        getPolicyDocumentsForAnnoymousUSer();
        getPolicyHTMLforAnnoymousUser();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});
function getPolicyDocumentsForAnnoymousUSer() {

    $.ajax({
        url: '/api/PolicyDocument',
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

                caseDocHtml = " <ol class='CaseDocfa-ul'>";

                for (var i = 0; i < arrFile.length; i++) {
                    var dRow = i + 1;
                    if (arrFile[i] != null && arrFile[i] != "") {

                        var last = arrFile[i].substring(arrFile[i].lastIndexOf("/") + 1, arrFile[i].length);

                        caseDocHtml += "<a target='_blank' href='" + arrFile[i] + "'><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dRow + " - " + last + "</li></a>";
                    }
                }
                caseDocHtml += "</ol >";

            }
            else {
                $('#divInfo').show();
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

function getPolicyHTMLforAnnoymousUser() {
    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/PolicyMasters?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#divCaseHtmContents').append(response[0].PolicyHTML);

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