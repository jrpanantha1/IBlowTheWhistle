$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        getCaseDocuments();
        loadCasePreActionMaster();
        getCaseManagementDetails();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }




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
                    $('#spnSubmissionDate').text(whistleResponse.SubmissionDateTime != null ? new Date(whistleResponse.SubmissionDateTime).toLocaleDateString('en-US', { hour: 'numeric', hour12: true }) : "");
                }
                if (caseMngt != null) {
                    $('#spnLastModifiyDate').text(new Date(caseMngt[0].CaseUpdated).toLocaleDateString() != null ? new Date(caseMngt[0].CaseUpdated).toLocaleDateString('en-US', { hour: 'numeric', hour12: true }) : "");
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
function loadCasePreActionMaster() {
    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/CasePreActionMasters?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                //$('#formTitle').text(response[0].FormTitle);
                var PreLength = response.length;
                $('#ddlCasePre').empty();
                for (var i = 0; i < PreLength; i++) {
                    $('#ddlCasePre').append(new Option(response[i].PreAction, response[i].PreAction));
                }
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
function validateSelectCaseTemplate() {
    var flag = true;

    if (!GetDropdownListBoxValidation($('#ddlCasePre'))) {
        flag = false;

    }
    return flag;
}
function updateCaseInformation(updateString) {

    if (updateString == "") {
        if (!validateCaseInfoControl()) {
            return false;
        }
    }

    var iurn = getUrlVars()["iURN"];

    var dataResponse = {
        "CaseInformation": updateString == "" ? $('#txtMessage').val() : updateString,
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
    $('#wrapper').empty();

    caseHTL = " <ul class='timeline'> ";
    caseHTL = "";

    caseHTL += "<div class='scrollbar' id='style-7'>" +
        "<div class='force - overflow'>" +
        "<div class='latupdtcont'>" +
        "<ul class='latupdt'>";

    for (var i = 0; i < objCaseColn.length; i++) {
        var caseInfo = objCaseColn[i].CaseInformation;

        var colorCode = "";


        //else if (caseInfo == "Case Opened") {
        //    colorCode = 'incidenttype2';
        //}

        //caseHTL += "<li>" +
        //    "<a  href='#' style='cursor:default'>Case updated on </a>" +
        //    "<a  href='#' style='cursor:default' class='float - right'>" + new Date(objCaseColn[i].CaseUpdated).toLocaleDateString('en-US', { hour: 'numeric', hour12: true }) + "</a>" +
        //    "<p class='" + colorCode + "'>" + caseInfo + "</p>" +
        //    "</li>";

        if (caseInfo == "Case Opened" || caseInfo.includes("Read")) {
            colorCode = 'luread';
        }
        else if (caseInfo.includes("Discarded")) {
            colorCode = 'disc';
        }
        else if (caseInfo.includes("Important")) {
            colorCode = 'luimp';
        }
        else if (caseInfo.includes("Done")) {
            colorCode = 'done';
        }
        else if (caseInfo.includes("Route to email")) {
            colorCode = 'rtm';
        }
        else if (caseInfo.indexOf("New") >= 0) {
            colorCode = 'latnewInc';
        }
        else {
            if (caseInfo.indexOf(".") >= 0) {
                colorCode = 'latupdoc';
            }
            else
                colorCode = 'latuplink';

        }
        //

        caseHTL += " <li class='" + colorCode + "'> <p>Case updated on " + new Date(objCaseColn[i].CaseUpdated).toLocaleDateString('en-US', { hour: 'numeric', hour12: true }) + "</p> <span>" + caseInfo + "</span></li>";

    }

    caseHTL += "</ul></div ></div ></div >";





    $('#wrapper').append(caseHTL);

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

            getCaseDocuments();
            updateCaseDocumentUploadInformation();
            $("#FileAttachmentDetails").val(null);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });


}
function updateCaseDocumentUploadInformation() {
    jQuery.each(jQuery('#FileAttachmentDetails')[0].files, function (i, file) {
        updateCaseInformation("The file " + file.name + " has been added");
    });
}
function ExportCaseHistroyToPDF() {
    var doc = new jsPDF();  //create jsPDF object

    var divContents = $("#wrapper").html();
    var divTopContents = $("#divCaseTop").html();

    //var a = [];
    //var imagesArray = $(divContents).find("img").each(function (index) {
    //    a[index] = $(this).html();
    //});
    //for (var i = 0; i < imagesArray.length; i++) {

    //    var find = imagesArray[i].currentSrc;
    //    find = find.substring(find.indexOf("/I"));
    //    //var find = ffind;//"/IBTWImages/4e2162b8-51f5-41fa-8eed-f0a4569bcca5/CompanyLogo.png";
    //    var re = new RegExp(find, 'g');

    //    divContents = divContents.replace(re, '#');
    //}

    var tranID = $('#spnIncID').text();

    doc.fromHTML(divTopContents + divContents, // page element which you want to print as PDF
        15,
        15,
        {
            'width': 170  //set width
        },
        function (a) {


            var today = new Date();
            var tDate = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

            doc.save("CaseHistroy - " + tranID + ".pdf"); // save file name as HTML2PDF.pdf
        });



}
