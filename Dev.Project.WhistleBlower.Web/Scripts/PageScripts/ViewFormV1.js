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

                $('.spanTraxID').text(IncResponse.IURN);
                $('.spanTraxDate').text(IncResponse.SubmissionDateTime.toLocaleString());

                $('#IsReportable').val(IncResponse.IsReportable == true ? "Yes" : "No");

                $('#HaveWitness').val(IncResponse.HaveWitness == true ? "Yes" : "No");
                IncResponse.HaveWitness == true ? $('#collapseHaveWitness').show() : $('#collapseHaveWitness').hide();
                $('#FileAttachment').val(IncResponse.FileAttachment == true ? "Yes" : "No");
                $('#UpdatedOnIncident').val(IncResponse.UpdatedOnIncident == true ? "Yes" : "No");
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
                    var arr = filesPaths.split(';');
                    for (var i = 0; i < arr.length; i++) {
                        var dd = i + 1;
                        if (arr[i] != "") {
                            $('#divAttachements').append("<a target='_blank' href=" + arr[i] + "> Document" + dd + "</a></br>");
                        }
                    }


                }
                else
                    $('.avatar').attr("style", "display:none")

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