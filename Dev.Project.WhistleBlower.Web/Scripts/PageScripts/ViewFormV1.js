$(document).ready(function () {
    debugger;
    if (localStorage.getItem('accessToken') != null) {
        getLabelDetails();
        var iurn = getUrlVars()["iURN"];
        loadFormDetails(iurn);
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

    menuEnableDisable();//ref Utility.js
    getViewBannerDetails();
    jQuery('[data-toggle="tooltip"]').tooltip();


});
$(window).on('load', function () {
    updateReadStatus();
});

function loadFormDetails(iURN) {

    $.ajax({
        url: '/api/ManageIncidents?IURN=' + iURN,
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            //Incidents details section start 
            if (response.IncDetails != null) {


                IncResponse = response.IncDetails;

                $('.spaTraxID').text(IncResponse.IURN);
                $('.spaTraxDate').text(IncResponse.SubmissionDateTime.toLocaleString());

                $('#IsReportable').val(IncResponse.IsReportable == true ? "Yes" : "No");

                $('#HaveWitness').val(IncResponse.HaveWitness == true ? "Yes" : "No");
                IncResponse.HaveWitness == true ? $('#collapseHaveWitness').show() : $('#collapseHaveWitness').hide();
                $('#FileAttachment').val(IncResponse.FileAttachment == true ? "Yes" : "No");
                $('#UpdatedOnIncident').val(IncResponse.UpdatedOnIncident == true ? "Yes" : "No");
                IncResponse.UpdatedOnIncident == true ? $('#collapseUpdatedOnIncident').show() : $('#collapseUpdatedOnIncident').hide();
                $('#UpdatedOnIncidentMethod').val(IncResponse.UpdatedOnIncidentMethod == "1" ? "Email" : IncResponse.UpdatedOnIncidentMethod == "2" ? "Phone" : "Anonymous");
                if (IncResponse.UpdatedOnIncidentMethod == "1") {
                    $('#collapseUpdatedOnIncidentMethodEmail').show();
                    $('#UpdatedOnIncidentMethodEmail').val(IncResponse.Email);
                }
                else if (IncResponse.UpdatedOnIncidentMethod == "2") {
                    $('#collapseUpdatedOnIncidentMethodPhone').show();
                    $('#UpdatedOnIncidentMethodPhone').val(IncResponse.Phone);

                }
                $('#comments').text(IncResponse.Comments);

                if (IncResponse.SupportingEvidence == true) {
                    $('#SupportingEvidence').val("Yes");
                    $('.collapseSupportingEvidence').show();
                }
                else {
                    $('#SupportingEvidence').val("No");
                    $('.collapseSupportingEvidence').hide();
                }


                if (IncResponse.SupportingEvidence == true) {
                    $('#EvidenceDetails').text(IncResponse.EvidenceDetails);
                } else
                    $('#collapseSupportingEvidence').hide();

                $('#EvidenceCanBeUsedForInvestigation').prop('checked', true);
                $('#customCheck1').prop('checked', true);

                if (IncResponse.SupportingDocuments != null && IncResponse.SupportingDocuments != "") {

                    var filesPaths = IncResponse.SupportingDocuments;
                    var caseDocHtml = " <ol class='CaseDocfa-ul'>";

                    var arr = filesPaths.split(';');
                    for (var i = 0; i < arr.length; i++) {
                        var dd = i + 1;
                        if (arr[i] != "") {
                            var fileName1 = arr[i].substring(arr[i].lastIndexOf("/") + 1, arr[i].length);

                            caseDocHtml += "<a target='_blank' href='" + arr[i] + "' download=" + fileName1 + "><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dd + " - " + fileName1 + "</li></a>";
                            //$('#divAttachements').append("<a target='_blank' href=" + arr[i] + " download=" + fileName1 + "> " + fileName1 + "</a></br>");
                        }
                    }
                    caseDocHtml += "</ol >";
                    $('#divAttachements').append(caseDocHtml);


                }
                //else
                //$('.avatar').attr("style", "display:none")

                if (localStorage.getItem("AcctType") != "Admin") {
                    if (IncResponse.ReportedLanguageID != "") {
                        sessionStorage.setItem("iBlowLanguage", IncResponse.ReportedLanguageID);
                        changeSelectedLanguageonBar(IncResponse.ReportedLanguageID);
                        getLabelDetails();
                    }
                }

            }
            //Witness details section start here
            if (response.witnessColn != null) {
                for (var i = 0; i < response.witnessColn.length; i++) {
                    if (i == 0) {


                        $('#WitnessFullName').val(controlIsNullCheck(response.witnessColn[i].FullName));
                        $('#WitnessEmail').val(controlIsNullCheck(response.witnessColn[i].Email));
                        $('#WitnessPhone').val(controlIsNullCheck(response.witnessColn[i].Phone));
                        disbaleWitnessControls(0, true);
                    }
                    if (i > 0) {
                        var newelement = $(".clone-witness").eq(0).clone();
                        var num = $('.clone-witness').length;
                        var newNum = num + 1;
                        newelement.find('input').each(function (i) {
                            $(this).attr('name', $(this).attr('name') + newNum);
                            $(this).attr('id', $(this).attr('id') + newNum);
                        });
                        newelement.find('label').each(function (i) {
                            $(this).attr('id', $(this).attr('id') + newNum);
                        });
                        //newelement.append('<div class="form-group"><button class="btn btn-sm btn-block btn-danger btn-remove" type="button"><i class="icon-minus"></i> Remove this witness</button></div>')
                        $('.clone-witness').last().after(newelement);
                        var tempNumber = i + 1;

                        disbaleWitnessControls(tempNumber, true);
                        $('#WitnessFullName' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].FullName));
                        $('#WitnessEmail' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].Email));
                        $('#WitnessPhone' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].Phone));
                    }

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
function controlIsNullCheck(controlValue) {
    var retValue = "";
    return retValue = controlValue != null && controlValue ? controlValue : "";
}
function disbaleWitnessControls(controlDynamicID, isDiable) {
    //.attr('disabled','disabled');
    $('#WitnessFullName').prop('disabled', isDiable);
    $('#WitnessEmail').prop('disabled', isDiable);
    $('#WitnessPhone').prop('disabled', isDiable);
    if (controlDynamicID != 0) {
        $('#WitnessFullName' + controlDynamicID).prop('disabled', isDiable);
        $('#WitnessEmail' + controlDynamicID).prop('disabled', isDiable);
        $('#WitnessPhone' + controlDynamicID).prop('disabled', isDiable);
    }
}

function dataURLtoFile(dataurl, filename) {

    var arr = dataurl.split(','),
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]),
        n = bstr.length,
        u8arr = new Uint8Array(n);

    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }

    return new File([u8arr], { type: mime });
}

function updateReadStatus() {

    var selectedID = getUrlVars()["vs"]
    if (selectedID == 1) {

        var ddlSelectedValue = 'Read';
        var iurnID = getUrlVars()["iURN"];

        $.ajax({
            url: '/api/ManageIncidents?IURN=' + iurnID + '&status=' + ddlSelectedValue + '',
            method: 'PUT',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
            },
            success: function (response) {
                if (response != null && response == "Success") {
                    updateCaseInformation(iurnID);
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
}
function updateCaseInformation(iurn) {


    var dataResponse = {
        "CaseInformation": "Case Opened",
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

function getViewBannerDetails() {
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

function changeSelectedLanguageonBar(languageText) {

    switch (languageText) {

        case "1": //English
            lanCode = 1;
            $("#dropdownLanguage").text("EN");
            break;
        //Thai
        case "2":
            $("#dropdownLanguage").text("TH");
            break;
        //French
        case "3":
            $("#dropdownLanguage").text("FR");
            break;
        //Spanish
        case "4":
            $("#dropdownLanguage").text("ES");
            break;
        //Russian
        case "5":
            $("#dropdownLanguage").text("RU");
            break;
        //Kazakh
        case "6":
            $("#dropdownLanguage").text("KZ");
            break;
        //Arabic
        case "7":
            $(".langDirection").css("direction", "ltr");
            $(".langDirection").css("text-align", "left");

            $("#dropdownLanguage").text("AR");
            break;

        //Chinese
        case "8":
            $("#dropdownLanguage").text("CN");
            break;

        //Hindi
        case "9":
            $("#dropdownLanguage").text("HI");
            break;

        //Urdu
        case "10":
            $(".langDirection").css("direction", "ltr");
            $(".langDirection").css("text-align", "left");
            $("#dropdownLanguage").text("UR");
            break;

        //Malay
        case "11":
            $("#dropdownLanguage").text("MS");
            break;

        default:

            $("#dropdownLanguage").text("EN");
            break;
    }
}
