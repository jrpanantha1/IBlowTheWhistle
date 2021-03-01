
function IncidentFormValidation() {
    var flag = true;

    if (!GetDropdownSelectedIndexValidation($('#IsReportable'))) {
        flag = false;
    }

    if (!GetDropdownSelectedIndexValidation($('#SupportingEvidence'))) {
        flag = false;
    }
    else if (!dropdownYesValidateText($('#SupportingEvidence'), $('#EvidenceDetails'))) {
        flag = false;
    }


    var incElm = $('#UpdatedOnIncident');
    var incElmMethod = $('#UpdatedOnIncidentMethod');
    var emailElm = $('#UpdatedOnIncidentMethodEmail');
    var phoneElm = $('#UpdatedOnIncidentMethodPhone');

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


    if (!GetDropdownSelectedIndexValidation($('#FileAttachment'))) {
        flag = false;
    }

    return flag;

}

function submitIncidentDetails() {
    var updateMethodNumber = 0;

    if ($('#UpdatedOnIncident').val() == "Yes") {
        updateMethodNumber = $('#UpdatedOnIncidentMethod').val() == "Email" ? 1 : $('#UpdatedOnIncidentMethod').val() == "Phone" ? 2 : 3
    }
    var WhistleBlowData =
    {
        "IsReportable": $('#IsReportable').val() == "No" ? 0 : 1,
        "SupportingEvidence": $('#SupportingEvidence').val() == "No" ? 0 : 1,
        "EvidenceDetails": $('#EvidenceDetails').val(),
        "FileAttachment": $('#FileAttachment').val() == "No" ? 0 : 1,
        "HaveWitness": $('#HaveWitness').val() == "No" ? 0 : 1,
        "UpdatedOnIncident": $('#UpdatedOnIncident').val() == "No" ? 0 : 1,
        "UpdatedOnIncidentMethod": updateMethodNumber,
        "Email": $('#UpdatedOnIncidentMethodEmail').val(),
        "Phone": $('#UpdatedOnIncidentMethodPhone').val(),
        "EvidenceCanBeUsedForInvestigation": true,
        "Comments": $('#comments').val(),
        "SupportingDocuments": CompanyLogoBase64,
        "WitnessFullName": $('#WitnessFullName').val(),
        "WitnessEmail": $('#WitnessEmail').val(),
        "WitnessPhone": $('#WitnessPhone').val()
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
        witnessColn: objWitnessDataColn
    });



    $.ajax({
        url: '/api/ManageIncidents',
        method: 'POST',
        data: strFinalData, //JSON.stringify(WhistleBlowData),
        async: false,
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {

                if (response[0].TransactionID != "") {
                    $('#trxID').text(response[0].TransactionID);
                    $('#annoymouslogin').hide();
                }
                if (response[0].AnnonymousUserName != "" && response[0].AnnonymousPassowrd != "") {
                    $('#spanUserName').text(response[0].AnnonymousUserName);
                    $('#spanPassword').text(response[0].AnnonymousPassowrd);
                    $('#annoymouslogin').show();
                }
                $('#AnonymousModal').modal('show');
                e.preventDefault();
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

var CompanyLogoBase64 = "";

function readFile(file, onLoadCallback) {
    var reader = new FileReader();

    reader.onload = onLoadCallback;
    reader.readAsDataURL(file);
}