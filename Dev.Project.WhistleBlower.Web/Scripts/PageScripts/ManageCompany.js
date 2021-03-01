

function Validation() {
    var flag = true;



    return flag;
}
function getLabelDetails() {

    var lanCode = 1;
    if (sessionStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/ManageCompany?formID=' + 1 + '&langID=' + lanCode,
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
                $('#lblFileAttachment').text(response[0].DoyouhaveanyDocument);
                $('#lblBrowseText').text(response[0].BrowseText);
                $('#lblHaveWitness').text(response[0].HaveWitness);
                $('#lblWitnessFullName').text(response[0].WitnessName);
                $('#lblWitnessEmail').text(response[0].WitnessEmail);
                $('#lblWitnessPhone').text(response[0].WitnessPhone);

                $('#lblUpdatedOnIncident').text(response[0].UpdatedOnIncident);
                $('#lblAckPolicy').text(response[0].AckPolicy);
                $('#lblIdentityNeverRevel').text(response[0].IdentityNeverRevel);
                $('#lblComments').text(response[0].Comments);

                $('#pAreYouWhistleBlower').text(response[0].AreYouWhistleBlower);
                $('#lblComments').text(response[0].Comments);
                $('#lblAuthrizeDeclaration').text(response[0].AuthrizeDeclaration);

                $('.optPleaseSelect').text(response[0].PleaseSelect);
                $('.optYes').text(response[0].Yes);
                $('.optNo').text(response[0].No);
                $('#btnSubmit').text(response[0].ReportIncident);

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

function submitIncidents() {

    var WhistleBlowData =
    {
        "CompanyID": '1',
        "IsReportable": $('#IsReportable').val() == "No" ? 0 : 1,
        "SupportingEvidence": $('#SupportingEvidence').val() == "No" ? 0 : 1,
        "EvidenceDetails": $('#EvidenceDetails').val(),
        "FileAttachment": $('#FileAttachment').val() == "No" ? 0 : 1,
        "HaveWitness": $('#HaveWitness').val() == "No" ? 0 : 1,
        "UpdatedOnIncident": $('#UpdatedOnIncident').val() == "No" ? 0 : 1,
        "UpdatedOnIncidentMethod": $('#UpdatedOnIncidentMethod').val() == "Email" ? 1 : $('#UpdatedOnIncidentMethod').val() == "Phone" ? 2 : 3,
        "Email": $('#UpdatedOnIncidentMethodEmail').val(),
        "Phone": $('#UpdatedOnIncidentMethodPhone').val(),
        "EvidenceCanBeUsedForInvestigation": true,
        "Comments": $('#comments').val(),
        "SupportingDocuments": CompanyLogoBase64,
        "WitnessFullName": $('#WitnessFullName').val(),
        "WitnessEmail": $('#WitnessEmail').val(),
        "WitnessPhone": $('#WitnessPhone').val()
    }

    $.ajax({
        url: '/api/ManageCompany',
        method: 'POST',
        data: JSON.stringify(WhistleBlowData),
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != null && response != "") {
                window.location.href = "/Pages/Confirmation.aspx?trxID=" + response;
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