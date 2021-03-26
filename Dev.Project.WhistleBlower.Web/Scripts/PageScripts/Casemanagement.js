$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
    getCaseDocuments();
    getCaseManagementDetails();


});
function getCaseManagementDetails() {
    var iurn = getUrlVars()["iURN"];
    $('#ancSendResponse').attr("href", "Response.aspx?iURN=" + iurn)
    $('#spnIncID').text(iurn);

    $.ajax({
        url: '/api/CaseManagements?IURN=' + iurn,
        method: 'GET',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {

                var whistleResponse = response.whistleBlowIncidentObj;
                var caseMngt = response.caseMngtColn;

                if (whistleResponse != null) {
                    $('#spnSubmissionDate').text(whistleResponse.SubmissionDateTime != null ? new Date(whistleResponse.SubmissionDateTime).toLocaleDateString() : "");
                }
                if (caseMngt != null) {
                    constructCaseTimeLine(caseMngt);
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


function getCaseDocuments() {
    var iurn = getUrlVars()["iURN"];

    $.ajax({
        url: '/api/FileUploader?IURN=' + iurn,
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

                        caseDocHtml += "<a target='_blank' href='" + arrFile[i] + "'><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dRow + " - " + last + "</li></a>";
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

function validateCaseInfoControl() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtMessage'))) {
        flag = false;

    }
    return flag;
}
function updateCaseInformation() {

    if (!validateCaseInfoControl()) {
        return false;
    }
    var iurn = getUrlVars()["iURN"];

    var dataResponse = {
        "CaseInformation": $('#txtMessage').val(),
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
                var items = response;
                $('#txtMessage').val("");
                getCaseManagementDetails();
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
function constructCaseTimeLine(objCaseColn) {

    var caseHTL = "";
    $('#divCaseTimeLine').empty();
    caseHTL = " <ul class='timeline'> ";
    for (var i = 0; i < objCaseColn.length; i++) {
        var caseInfo = objCaseColn[i].CaseInformation;

        caseHTL += "<li>" +
            "<a  href='#' style='cursor:default'>Case updated on </a>" +
            "<a  href='#' style='cursor:default' class='float - right'>" + new Date(objCaseColn[i].CaseUpdated).toLocaleDateString() + "</a>" +
            "<p>" + caseInfo + "</p>" +
            "</li>";
    }

    caseHTL += "</ul>";
    $('#divCaseTimeLine').append(caseHTL);

}

function CaseDocumentValidation() {
    var caseFileControl = $('#FileAttachmentDetails');

    if (caseFileControl.val() == null || caseFileControl.val() == "") {
        flag = false;
        caseFileControl.addClass('error');
    }
    else {
        caseFileControl.removeClass('error');
    }
}

function uploadCaseDocuments() {

    if (CaseDocumentValidation()) {
        return false;
    }
    var iurn = getUrlVars()["iURN"];

    var data = new FormData();
    jQuery.each(jQuery('#FileAttachmentDetails')[0].files, function (i, file) {
        data.append('file-' + i, file);
    });

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
        data: data,
        success: function (data, textStatus, xhr) {
            $("#FileAttachmentDetails").val(null);
            getCaseDocuments();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });


}
