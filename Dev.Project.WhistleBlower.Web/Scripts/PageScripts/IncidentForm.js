$(document).ready(function () {
    debugger;
    if (localStorage.getItem('accessToken') != null) {
        getLabelDetails();//ref Utility.js; load multilingual label information from DB
        getCompanyProfile();
    }
    else {
        window.location.href = "/Pages/Default.aspx";
    }


});


function getCompanyProfile() {
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

                if (response.CompanyName != null && response.CompanyName != "") {
                    $("#h1CompanyName").text(response.CompanyName);// display in View Incident and Reoprt Incodent top 
                }
                if (localStorage.getItem("AcctType") == "Admin") {
                    $('#btnGoHome').hide();
                    $('#btnGoClose').show();
                    $('.UpdatedOnIncidentDisableForAdmin').hide();
                    $('#collapseUpdatedOnIncident').hide();
                    $('.signIn').hide();
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


var thisElm;
var fileData;

function IncidentFormValidation() {
    var flag = true;

    if (!GetDropdownSelectedIndexValidation($('#IsReportable'))) {
        flag = false;
    }
    if (!GetCheckboxWithLabelValidation($('#EvidenceCanBeUsedForInvestigation'), $('#lblAuthrizeDeclaration'))) {
        flag = false;
    }

    if (!GetCheckboxWithLabelValidation($('#customCheck1'), $('#lblAckPolicy'))) {
        flag = false;
    }


    if (!GetDropdownSelectedIndexValidation($('#SupportingEvidence'))) {
        flag = false;
    }
    else if (!dropdownYesValidateText($('#SupportingEvidence'), $('#EvidenceDetails'))) {
        flag = false;

        if (!GetDropdownSelectedIndexValidation($('#FileAttachment'))) {
            flag = false;
        }

    }

    if (!GetTextBoxEmptyValidation($('#comments'))) {
        flag = false;
    }



    var incElm = $('#UpdatedOnIncident');
    var incElmMethod = $('#UpdatedOnIncidentMethod');
    var emailElm = $('#UpdatedOnIncidentMethodEmail');
    var phoneElm = $('#UpdatedOnIncidentMethodPhone');

    if (localStorage.getItem("AcctType") != "Admin") {

        if (incElm.val() == null || incElm.find(":selected").index() == 0 || incElm.val() == "") {
            flag = false;
            incElm.addClass('error');
        }
        else if (incElm.val() == null || incElm.find(":selected").index() == 2 || incElm.val() == "") {
            incElm.removeClass('error');
            incElmMethod.removeClass('error');
            emailElm.removeClass('error');
            phoneElm.removeClass('error');
        }
        else {
            incElm.removeClass('error');


            if (incElmMethod.val() == null || incElmMethod.find(":selected").index() == 0 || incElmMethod.val() == "") {
                flag = false;
                incElmMethod.addClass('error');
            }
            else {
                incElmMethod.removeClass('error');
                if (incElmMethod.find(":selected").index() == 1) {

                    if (emailElm.val() == null || emailElm.val() == "") {
                        flag = false;
                        emailElm.addClass('error');
                    }
                    else {
                        emailElm.removeClass('error');
                    }
                }
                if (incElmMethod.find(":selected").index() == 2) {

                    if (phoneElm.val() == null || phoneElm.val() == "") {
                        flag = false;
                        phoneElm.addClass('error');
                    }
                    else {
                        phoneElm.removeClass('error');
                    }
                }
            }

        }
    }


    var wName = $('#WitnessFullName');
    var wEmail = $('#WitnessEmail');
    var wPhone = $('#WitnessPhone');


    if (!GetDropdownSelectedIndexValidation($('#HaveWitness'))) {
        flag = false;
    }
    else if ($('#HaveWitness').find(":selected").index() == 1) {


        if ((wName.val() == null || wName.val() == "") && (wEmail.val() == null || wEmail.val() == "") && (wPhone.val() == null || wPhone.val() == "")) {
            flag = false;
            wName.addClass('error');
            wEmail.addClass('error');
            wPhone.addClass('error');

        }
        else {
            wName.removeClass('error');
            wEmail.removeClass('error');
            wPhone.removeClass('error');
        }
        //if additional witness added
        var cloneLength = $('.clone-witness').length;
        for (var i = 1; i < cloneLength; i++) {

            var tempNum = i + 1;
            var wName1 = $('#WitnessFullName' + tempNum);
            var wEmail1 = $('#WitnessEmail' + tempNum);
            var wPhone1 = $('#WitnessPhone' + tempNum);

            if ((wName1.val() == null || wName1.val() == "") && (wEmail1.val() == null || wEmail1.val() == "") && (wPhone1.val() == null || wPhone1.val() == "")) {
                flag = false;
                wName1.addClass('error');
                wEmail1.addClass('error');
                wPhone1.addClass('error');

            }
            else {
                wName1.removeClass('error');
                wEmail1.removeClass('error');
                wPhone1.removeClass('error');
            }

        }


    }
    else {
        wName.removeClass('error');
        wEmail.removeClass('error');
        wPhone.removeClass('error');
    }



    return flag;

}

function submitIncidentDetails() {
    var updateMethodNumber = 0;


    var data = new FormData();
    var files = $("#FileAttachmentDetails").get(0).files;

    // Add the uploaded file to the form data collection  
    if (files.length > 0) {
        for (f = 0; f < files.length; f++) {
            data.append("UploadedImage", files[f]);
        }
    }


    if ($('#UpdatedOnIncident').val() == "Yes") {
        updateMethodNumber = $('#UpdatedOnIncidentMethod').val() == "Email" ? 1 : $('#UpdatedOnIncidentMethod').val() == "Phone" ? 2 : 3
    }
    var WhistleBlowData =
    {
        "IsReportable": $('#IsReportable').val() == "Yes" ? 1 : 0,
        "SupportingEvidence": $('#SupportingEvidence').val() == "Yes" ? 1 : 0,
        "EvidenceDetails": $('#EvidenceDetails').val(),
        "FileAttachment": $('#FileAttachment').val() == "Yes" ? 1 : 0,
        "HaveWitness": $('#HaveWitness').val() == "Yes" ? 1 : 0,
        "UpdatedOnIncident": $('#UpdatedOnIncident').val() == "Yes" ? 1 : 0,
        "UpdatedOnIncidentMethod": updateMethodNumber,
        "Email": $('#UpdatedOnIncidentMethodEmail').val(),
        "Phone": $('#UpdatedOnIncidentMethodPhone').val(),
        "EvidenceCanBeUsedForInvestigation": true,
        "Comments": $('#comments').val(),
        "SupportingDocuments": "",
        "SupportingDocuments1": "",
        "SupportingDocuments2": "",
        "WitnessFullName": $('#WitnessFullName').val(),
        "WitnessEmail": $('#WitnessEmail').val(),
        "WitnessPhone": $('#WitnessPhone').val(),
        "ReportedLanguageID": sessionStorage.getItem("iBlowLanguage")
    }
    var objWitnessDataColn = [];

    if ($('#HaveWitness').val() == "Yes") {
        //if witness count more than one

        var wName1 = $('#WitnessFullName').val();
        var wEmail1 = $('#WitnessEmail').val();
        var wPhone1 = $('#WitnessPhone').val();

        objWitnessDataColn.push({ FullName: wName1, Email: wEmail1, Phone: wPhone1 });

        var cloneLength = $('.clone-witness').length;
        for (var i = 1; i < cloneLength; i++) {

            //var dd = '#WitnessFullName' + i;
            var tempNum = i + 1;
            wName1 = $('#WitnessFullName' + tempNum).val();
            wEmail1 = $('#WitnessEmail' + tempNum).val();
            wPhone1 = $('#WitnessPhone' + tempNum).val();

            objWitnessDataColn.push({ FullName: wName1, Email: wEmail1, Phone: wPhone1 });

        }
    }

    var strFinalData = JSON.stringify({
        IncDetails: WhistleBlowData,
        witnessColn: objWitnessDataColn,
        ibtwFiles: data
    });



    $.ajax({
        url: '/api/ManageIncidents',
        method: 'POST',
        data: strFinalData, //JSON.stringify(WhistleBlowData),
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {

                var successTranxID = response[0].TransactionID;

                var IncFileControl = $('#FileAttachmentDetails');
                if (IncFileControl.val() != null || IncFileControl.val() != "") {
                    uploadIncidentDocuments(successTranxID, response);
                }
                else {

                    finalProcess(successTranxID, response);
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
function finalProcess(successTranxID, response) {
    if (successTranxID != "") {
        $('#trxID').text(successTranxID);
        $('#annoymouslogin').hide();
        $('#txtTran').val(successTranxID);
    }
    if (response[0].AnonymousUserName != "" && response[0].AnonymousPassowrd != "") {
        $('#spanUserName').text(response[0].AnonymousUserName);
        $('#txtUname').val(response[0].AnonymousUserName);
        $('#spanPassword').text(response[0].AnonymousPassowrd);
        $('#txtPass').val(response[0].AnonymousPassowrd);
        $('#annoymouslogin').show();
    }

    $('#AnonymousModal').modal('show');
    if (localStorage.getItem("AcctType") != "Admin") {
        $('#btnGoHome').show();
        $('#btnGoClose').hide();
    }
    else {
        $('#btnGoHome').hide();
        $('#btnGoClose').show();
    }
}
function uploadIncidentDocuments(tranxIURN, response) {

    var iurn = tranxIURN;

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
            finalProcess(tranxIURN, response);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });


}
function myFunctionUserName() {

    var copyText = document.getElementById("txtUname");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipName");
    tooltip.innerHTML = "Copied: " + copyText.value;

}
function myFunctionPassword() {
    var copyText = document.getElementById("txtPass");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = "Copied: " + copyText.value;
}
function myFunctionTransation() {
    var copyText = document.getElementById("txtTran");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipTran");
    tooltip.innerHTML = "Copied: " + copyText.value;
}

function outFunc() {
    var tooltip = document.getElementById("myTooltipName");
    tooltip.innerHTML = "Copy to clipboard";
}
function outFuncPass() {
    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = "Copy to clipboard";
}
function outFuncTran() {
    var tooltip = document.getElementById("myTooltipTran");
    tooltip.innerHTML = "Copy to clipboard";
}

var CompanyLogoBase64 = "";
var CompanyLogoBase641 = "";
var CompanyLogoBase642 = "";
function readFile(file, onLoadCallback) {
    var reader = new FileReader();

    reader.onload = onLoadCallback;
    reader.readAsDataURL(file);
}

