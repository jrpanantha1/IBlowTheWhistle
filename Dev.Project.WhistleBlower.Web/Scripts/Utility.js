
function enquryFormValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#firstName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#lastName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#email'))) {
        flag = false;
    }
    if (flag) {
        SendEmailEnquiryNotification();
    }
}
function SendEmailEnquiryNotification() {


    var enqData =
    {
        "emailAddress": $('#email').val(),
        "firstName": $('#firstName').val(),
        "lastName": $('#lastName').val(),
    }

    $.ajax({
        url: '/api/Exchange',
        type: "POST",
        data: JSON.stringify(enqData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            alert('Your Request has been notified to Blow Whistle Admin Team Successfully.');
        },
        error: function (response) {

            alert(response.responseText);
        },
        failure: function (response) {
            alert(response.responseText);
        },

    });

}
function getLanguageCode() {

    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }
    return lanCode;
}
function getLabelDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/LanguageDetails?formID=' + 1 + '&langID=' + lanCode,
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#ReportIncident').text(response[0].ReportIncident);
                $('#lblIsReportable').text(response[0].IsReportable);
                $('#lblSupportingEvidence').text(response[0].SupportingEvidence);
                $('#lblEvidenceDetails').text(response[0].EvidenceDetails);
                $('#EvidenceDetails').attr("placeholder", response[0].EvidenceDetailsPHT);
                $('#lblFileAttachment').text(response[0].DoyouhaveanyDocument);
                $('#lblBrowseText').text(response[0].BrowseText);
                $('#lblHaveWitness').text(response[0].HaveWitness);
                $('#lblWitnessFullName').text(response[0].WitnessName);
                $('#lblWitnessEmail').text(response[0].WitnessEmail);
                $('#lblWitnessPhone').text(response[0].WitnessPhone);

                $('#lblWitnessFullName1').text(response[0].WitnessName);
                $('#lblWitnessEmail1').text(response[0].WitnessEmail);
                $('#lblWitnessPhone1').text(response[0].WitnessPhone);


                $('#lblUpdatedOnIncident').text(response[0].UpdatedOnIncident);
                $('#lblHowWouldUpdate').text(response[0].HowWouldUpdated);
                $('#lblAckPolicy').html(response[0].AckPolicy);
                $('#lblIdentityNeverRevel').text(response[0].IdentityNeverRevel);
                $('#lblComments').text(response[0].Comments);
                $('#comments').attr("placeholder", response[0].ConcernDetailsPHT);

                $('#pAreYouWhistleBlower').text(response[0].AreYouWhistleBlower);
                $('#lblComments').text(response[0].Comments);
                $('#lblAuthrizeDeclaration').text(response[0].AuthrizeDeclaration);

                $('#lblEmailAddress').text(response[0].EmailAddresslbl);
                $('#lblPhone').text(response[0].Phonelbl);

                $('.optPleaseSelect').text(response[0].PleaseSelect);
                $('.optYes').text(response[0].Yes);
                $('.optNo').text(response[0].No);
                $('#btnSubmit').text(response[0].ReportIncident);

                $('.optByEmail').text(response[0].ByEmailUpdate);
                $('.optByPhone').text(response[0].ByPhoneUpdate);
                $('.optByAnonymous').text(response[0].AnonymousUpdate);
                $('.ancViewDoc').text(response[0].ViewDocumentsLnk);

                $('#btnClose').text(response[0].CloseBtn);

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
function menuEnableDisable() {
    if (sessionStorage.getItem('AcctType') != null || localStorage.getItem('AcctType') != null) {

        if (sessionStorage.getItem('AcctType') == "Admin" || localStorage.getItem('AcctType') == "Admin") {
            $('.dashboardMenu').show();
        }
        else
            $('.dashboardMenu').hide();
        // if the user is anonymous then disable preferance menu
        if (sessionStorage.getItem('AcctType') == "Anonymous User" || localStorage.getItem('AcctType') == "Anonymous User") {
            $('.preferencesMenu').hide();
        }
    }
}
function isAdmin() {
    var isAdminAcctType = false;

    if (sessionStorage.getItem('AcctType') != null || localStorage.getItem('AcctType') != null) {

        if (sessionStorage.getItem('AcctType') == "Admin" || localStorage.getItem('AcctType') == "Admin") {
            isAdminAcctType = true;
        }
        return isAdminAcctType;
    }
}

function showSuccessMessage(strMessage) {
    $.Toast("Success", strMessage, "success", {
        //has_icon: true,
        has_close_btn: true,
        stack: true,
        fullscreen: true,
        timeout: 8000,
        sticky: false,
        has_progress: true,
        rtl: false,
    });
}

function getLangCode() {

    var lanCode = 1;
    if (sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") {
        lanCode = sessionStorage.getItem("iBlowLanguage").toString();
    }
    else if (localStorage.getItem("iBlowLanguage") != null && localStorage.getItem("iBlowLanguage") != "null" && localStorage.getItem("iBlowLanguage").toString() != "") {
        lanCode = localStorage.getItem("iBlowLanguage").toString();
    }
    return lanCode;
}