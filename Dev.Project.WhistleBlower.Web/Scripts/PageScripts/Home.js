$(document).ready(function () {
    getCompanyNumber();
    loadHomeLanguageDetails();
});
function Validation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#CompanyURN'))) {
        flag = false;
    }

    return flag;
}
function validateCompanyKey() {

    //clear all storage is its come from home screen
    sessionStorage.clear();
    //localStorage.clear();
    localStorage.removeItem("accessToken");
    sessionStorage.removeItem("accessToken");

    var comValue = $('#CompanyURN').val();
    var comKey = "";


    var userData = {
        username: comKey,
        password: comValue,
        grant_type: 'password',
    }

    $.ajax({

        url: '/token',
        method: "POST",
        data: userData,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',

        success: function (response) {

            localStorage.setItem("accessToken", response.access_token);
            window.location.href = "/Pages/IncidentForm.aspx";

        },
        error: function (response) {

            if (response.responseText == "{\"error\":\"Login Error\"}") {
                //alert('Complany ID is not Valid');
                $('.alert-warning').show();
            } else if (response.responseText == "{\"error\":\"Invalid user company\"}") {
                //alert('Complany ID is not Valid');
                $('.alert-warning').show();
            }
            else {
                //alert('Complany ID is not Valid/ Invalid User Name and Password');
                $('.alert-warning').show();
            }
            //window.location.href = "/Pages/Default.aspx";

        },
        failure: function (response) {


        },
        complete: function () {

        }
    })


}

function getCompanyNumber() {

    $.ajax({
        url: '/api/CompanyMasters/1',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != "") {
                $('#CompanyURN').val(response.CompanyValue);
                localStorage.setItem("AcctType", "");
            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });

}

function loadHomeLanguageDetails() {

    var lanCode = 1;
    if (localStorage.getItem("iBlowLanguage") != null) {
        lanCode = localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/HomeLanguages?langID=' + Number(lanCode),
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != "") {
                $('#ancMenuInfo').text(response[0].menuInfo);
                $('#ancMenuPricing').text(response[0].menuPricing);
                $('#ancSignIn').text(response[0].menuSignIn);
                //inc box and button
                $('#hIncTitle').text(response[0].IncTitle);
                $('#pIncDesc').text(response[0].IncTitleDesc);
                $('#spanSecMsg').text(response[0].IncTitleSecMsg);
                $('#basic-addon2').text(response[0].btnSubmit);

                //box1
                $('#spanBoxTitle').text(response[0].boxEverythingNedToKnowTitle);
                $('#pboxDesc').text(response[0].boxEverythingNedToKnowDesc);
                $('#ancClickhere').text(response[0].boxClickHere);

                //contact us
                $('#hContactUs').text(response[0].ContactUsTitle);
                $('#hContactUsDesc').text(response[0].ContactUsDesc);

                $('#lblDoYouWant').text(response[0].ContDisclaimerDoyouWant);
                $('#lblDoYouWantChkbox').text(response[0].ContDisclaimerChkbox);
                $('#lblReadMore').html(response[0].ContactReadMorelbl);
                $('#sub_btn').text(response[0].ContactSendBtn);

                //placeholder text
                $('#CompanyURN').attr("placeholder", response[0].IncTitlePlcHolder);
                $('#firstName').attr("placeholder", response[0].ContactFNamePlcHolder);
                $('#lastName').attr("placeholder", response[0].ContactLNamePlcHolder);
                $('#email').attr("placeholder", response[0].ContactEmailPlcHolder);
                $('#message').attr("placeholder", response[0].ContactMessagePlcHolder);

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