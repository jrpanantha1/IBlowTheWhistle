$(document).ready(function () {
    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        loadLanguageLabelDetails()
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});

function loadLanguageLabelDetails() {


    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/LanguageDetailsByCompanies?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                var rResponse = response;

                var defaultText = response.objLangDetails[0];
                var currentText = response.objLangPerCompany[0] != null ? response.objLangPerCompany[0] : response.objLangDetails[0];

                //var str = JSON.stringify(rResponse);
                //var obj1 = JSON.parse(str);
                //var htmlString = " <table id='main-table' class='main-table'>  <thead><tr><th style='display:none;' scope ='col'>ColID</th> <th style='width:5%;text-align: center;vertical-align: middle;' scope ='col'> S.No</th> <th style='vertical-align: middle;' scope ='col' >Default English</th><th style='width:50%;' scope ='col' >Current label Text</th> </tr ></thead >";

                //var autoNUmber = 1;

                //for (var k in obj1) {
                //    if (obj1.hasOwnProperty(k)) {

                //        //alert("Key is " + k + ", value is " + obj1[k]);

                //        var cText = obj1[k] != null ? obj1[k] != "1" ? obj1[k] : "" : "";


                //        if (cText != "") {
                //            htmlString += "<tr><td style='display:none;'>" + k + "</td><td style='width:5%;text-align: center;vertical-align: middle;'>" + autoNUmber + "</td><td style='vertical-align: middle;'>" + cText + "</td><td style='width:50%;'><textarea id='txt" + k + "' rows='2' style='width:100%;'>" + cText + "</textarea></td></tr >";
                //            autoNUmber += 1;
                //        }

                //    }
                //}
                //htmlString += "</table>";

                //default and current text update
                $("#txtAckPolicy").val(currentText.AckPolicy);
                $("#tdtxtAckPolicy").html(defaultText.AckPolicy);

                $("#txtAdditionalComments").val(currentText.AdditionalComments);
                $("#tdtxtAdditionalComments").html(defaultText.AdditionalComments);

                $("#txtAnonymousUpdate").val(currentText.AnonymousUpdate);
                $("#tdtxtAnonymousUpdate").html(defaultText.AnonymousUpdate);

                $("#txtAreYouWhistleBlower").val(currentText.AreYouWhistleBlower);
                $("#tdtxtAreYouWhistleBlower").html(defaultText.AreYouWhistleBlower);

                $("#txtAServiceForm").val(currentText.AServiceForm);
                $("#tdtxtAServiceForm").html(defaultText.AServiceForm);

                $("#txtAuthrizeDeclaration").val(currentText.AuthrizeDeclaration);
                $("#tdtxtAuthrizeDeclaration").html(defaultText.AuthrizeDeclaration);

                $("#txtBrowseText").val(currentText.BrowseText);
                $("#tdtxtBrowseText").html(defaultText.BrowseText);

                $("#txtByEmailUpdate").val(currentText.ByEmailUpdate);
                $("#tdtxtByEmailUpdate").html(defaultText.ByEmailUpdate);

                $("#txtByPhoneUpdate").val(currentText.ByPhoneUpdate);
                $("#tdtxtByPhoneUpdate").html(defaultText.ByPhoneUpdate);

                $("#txtCloseBtn").val(currentText.CloseBtn);
                $("#tdtxtCloseBtn").html(defaultText.CloseBtn);

                $("#txtComments").val(currentText.Comments);
                $("#tdtxtComments").html(defaultText.Comments);

                $("#txtConcernDetailsPHT").val(currentText.ConcernDetailsPHT);
                $("#tdtxtConcernDetailsPHT").html(defaultText.ConcernDetailsPHT);

                $("#txtDoyouhaveanyDocument").val(currentText.DoyouhaveanyDocument);
                $("#tdtxtDoyouhaveanyDocument").html(defaultText.DoyouhaveanyDocument);

                $("#txtEmailAddresslbl").val(currentText.EmailAddresslbl);
                $("#tdtxtEmailAddresslbl").html(defaultText.EmailAddresslbl);

                $("#txtEvidenceDetails").val(currentText.EvidenceDetails);
                $("#tdtxtEvidenceDetails").html(defaultText.EvidenceDetails);

                $("#txtEvidenceDetailsPHT").val(currentText.EvidenceDetailsPHT);
                $("#tdtxtEvidenceDetailsPHT").html(defaultText.EvidenceDetailsPHT);

                $("#txtHaveWitness").val(currentText.HaveWitness);
                $("#tdtxtHaveWitness").html(defaultText.HaveWitness);

                $("#txtHowWouldUpdated").val(currentText.HowWouldUpdated);
                $("#tdtxtHowWouldUpdated").html(defaultText.HowWouldUpdated);


                $("#txtIdentityNeverRevel").val(currentText.IdentityNeverRevel);
                $("#tdtxtIdentityNeverRevel").html(defaultText.IdentityNeverRevel);

                $("#txtIsReportable").val(currentText.IsReportable);
                $("#tdtxtIsReportable").html(defaultText.IsReportable);

                $("#txtNo").val(currentText.No);
                $("#tdtxtNo").html(defaultText.No);

                $("#txtNoFileSelected").val(currentText.NoFileSelected);
                $("#tdtxtNoFileSelected").html(defaultText.NoFileSelected);

                $("#txtPhonelbl").val(currentText.Phonelbl);
                $("#tdtxtPhonelbl").html(defaultText.Phonelbl);

                $("#txtPleaseSelect").val(currentText.PleaseSelect);
                $("#tdtxtPleaseSelect").html(defaultText.PleaseSelect);

                $("#txtPrivacyPolicy").val(currentText.PrivacyPolicy);
                $("#tdtxtPrivacyPolicy").html(defaultText.PrivacyPolicy);

                $("#txtReportIncident").val(currentText.ReportIncident);
                $("#tdtxtReportIncident").html(defaultText.ReportIncident);

                $("#txtSignin").val(currentText.Signin);
                $("#tdtxtSignin").html(defaultText.Signin);

                $("#txtSupportingEvidence").val(currentText.SupportingEvidence);
                $("#tdtxtSupportingEvidence").html(defaultText.SupportingEvidence);

                $("#txtTermsofService").val(currentText.TermsofService);
                $("#tdtxtTermsofService").html(defaultText.TermsofService);

                $("#txtUpdatedOnIncident").val(currentText.UpdatedOnIncident);
                $("#tdtxtUpdatedOnIncident").html(defaultText.UpdatedOnIncident);

                $("#txtViewDocumentsLnk").val(currentText.ViewDocumentsLnk);
                $("#tdtxtViewDocumentsLnk").html(defaultText.ViewDocumentsLnk);

                $("#txtWitnessEmail").val(currentText.WitnessEmail);
                $("#tdtxtWitnessEmail").html(defaultText.WitnessEmail);

                $("#txtWitnessName").val(currentText.WitnessName);
                $("#tdtxtWitnessName").html(defaultText.WitnessName);

                $("#txtWitnessPhone").val(currentText.WitnessPhone);
                $("#tdtxtWitnessPhone").html(defaultText.WitnessPhone);

                $("#txtYes").val(currentText.Yes);
                $("#tdtxtYes").html(defaultText.Yes);

                autosize($('textarea'));
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


function updateLangDetailsValidation() {
    var flag = true;

    //if (!GetTextBoxEmptyValidation($('#txtStatusCode'))) {
    //    flag = false;
    //}
    //if (!GetTextBoxEmptyValidation($('#txtStatusDesc'))) {
    //    flag = false;
    //}
    return flag;
}
function addNewLabelText() {

    var lanCode = getLanguageCode();// utlity.js

    var dataLable = {
        "LanguageID": lanCode,
        "AServiceForm": $("#txtAServiceForm").val(),
        "AckPolicy": $("#txtAckPolicy").val(),
        "AdditionalComments": $("#txtAdditionalComments").val(),
        "AnonymousUpdate": $("#txtAnonymousUpdate").val(),
        "AreYouWhistleBlower": $("#txtAreYouWhistleBlower").val(),
        "AuthrizeDeclaration": $("#txtAuthrizeDeclaration").val(),
        "BrowseText": $("#txtBrowseText").val(),
        "ByEmailUpdate": $("#txtByEmailUpdate").val(),
        "ByPhoneUpdate": $("#txtByPhoneUpdate").val(),
        "CloseBtn": $("#txtCloseBtn").val(),
        "Comments": $("#txtComments").val(),
        "ConcernDetailsPHT": $("#txtConcernDetailsPHT").val(),
        "DoyouhaveanyDocument": $("#txtDoyouhaveanyDocument").val(),
        "EmailAddresslbl": $("#txtEmailAddresslbl").val(),
        "EvidenceCanBeUsedForInvestigation": $("#txtEvidenceCanBeUsedForInvestigation").val(),
        "EvidenceDetails": $("#txtEvidenceDetails").val(),
        "EvidenceDetailsPHT": $("#txtEvidenceDetailsPHT").val(),
        "HaveWitness": $("#txtHaveWitness").val(),
        "HowWouldUpdated": $("#txtHowWouldUpdated").val(),
        "IdentityNeverRevel": $("#txtIdentityNeverRevel").val(),
        "IsReportable": $("#txtIsReportable").val(),
        "No": $("#txtNo").val(),
        "NoFileSelected": $("#txtNoFileSelected").val(),
        "Phonelbl": $("#txtPhonelbl").val(),
        "PleaseSelect": $("#txtPleaseSelect").val(),
        "PrivacyPolicy": $("#txtPrivacyPolicy").val(),
        "ReportIncident": $("#txtReportIncident").val(),
        "Signin": $("#txtSignin").val(),
        "SubmissionDateTime": $("#txtSubmissionDateTime").val(),
        "SubmissionModifiedDate": $("#txtSubmissionModifiedDate").val(),
        "SupportingEvidence": $("#txtSupportingEvidence").val(),
        "TermsofService": $("#txtTermsofService").val(),
        "UpdatedOnIncident": $("#txtUpdatedOnIncident").val(),
        "ViewDocumentsLnk": $("#txtViewDocumentsLnk").val(),
        "WitnessEmail": $("#txtWitnessEmail").val(),
        "WitnessName": $("#txtWitnessName").val(),
        "WitnessPhone": $("#txtWitnessPhone").val(),
        "Yes": $("#txtYes").val()

    };

    $.ajax({
        url: '/api/LanguageDetailsByCompanies',
        method: 'POST',
        data: JSON.stringify(dataLable),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "" && response == "Success") {
                showSuccessMessage("New label has been added successfully.");
                loadLanguageLabelDetails();
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
function callResetDefault() {
    var lanCode = getLanguageCode();// utlity.js

    if (confirm("Are you sure?")) {
        deleteLanguageByLangLangCode(lanCode);
    }
}
function deleteLanguageByLangLangCode(rLanCode) {

    $.ajax({
        url: '/api/LanguageDetailsByCompanies?langID=' + rLanCode,
        method: 'DELETE',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response == "Success") {
                showSuccessMessage("Record restored successfully.");
                loadLanguageLabelDetails();
            }
        },
        error: function (response) {
            alert(response.responseText);
            //shownewForm();
        },
        failure: function (response) {
            alert(response.responseText);
            //shownewForm();
        }
    });
}