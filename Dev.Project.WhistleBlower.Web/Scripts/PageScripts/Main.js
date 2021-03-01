
$(document).ready(function () {
    validateCompany();
    //if (sessionStorage.getItem('accessToken') == null) {
    //    validateCompany();
    //}
    //else { getLabelDetails(); }

});
function validateCompany() {


    var comKey = "WIPIBTW";
    var comValue = "WIP123321";

    var userData = {
        username: comKey,
        password: comValue,
        grant_type: 'password',
    }

    $.ajax({

        url: '/token',
        method: "POST",
        data: userData,//JSON.stringify(userData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',

        success: function (response) {

            sessionStorage.setItem("accessToken", response.access_token);
            getLabelDetails();
        },
        error: function (response) {

            if (response.responseText == "{\"error\":\"Login Error\"}") {
                alert('Complany ID is not Valid');
            } else if (response.responseText == "{\"error\":\"Invalid user company\"}") {
                alert('Complany ID is not Valid');
            }
            else {
                alert('Complany ID is not Valid/ Invalid User Name and Password');
            }
            window.location.href = "/Pages/Home.aspx";

        },
        failure: function (response) {


        },
        complete: function () {

        }
    })


}
function getLabelDetails() {


    var lanCode = 1;
    if (sessionStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage").toString();
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
