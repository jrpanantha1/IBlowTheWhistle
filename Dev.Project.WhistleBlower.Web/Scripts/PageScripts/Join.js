function JoinValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtFirstName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtGivenName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtCountry'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtCompanyName'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtCompanyTele'))) {
        flag = false;
    }
    if (!ValidateEmail($('#txtCompanyEmail'))) {
        flag = false;
    }

    return flag;
}


function submitJoinDetails() {

    var iBTWProspectObj = {
        "FirstName": $('#txtFirstName').val(),
        "GivenName": $('#txtGivenName').val(),
        "CompanyName": $('#txtCompanyName').val(),
        "CompanyEmail": $('#txtCompanyEmail').val(),
        "txtCompanyTele": $('#CompanyTelephone').val(),
        "Country": $('#txtCountry').val(),
        "BriefDesc": $('#txtComments').val()
    };


    $.ajax({
        url: '/api/IBTWProspects',
        type: "POST",
        data: JSON.stringify(iBTWProspectObj),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            $('#divSuccess').show();
            $(".removeLater").val("");
        },
        error: function (response) {

            alert(response.responseText);
        },
        failure: function (response) {
            //alert(response.responseText);
        },

    });

}