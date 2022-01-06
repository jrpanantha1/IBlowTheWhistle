$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        getAccountLists();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }


    $(".comanyListDDL").change(function () {
        var selValue = $('#ddlAccountList').val();
        getAccountPassword(selValue);
    });
});

function getAccountLists() {

    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {
                var comLength = response.length;
                $('#ddlCompanyList').empty();

                for (var i = 0; i < comLength; i++) {
                    var opt = $("<option>").val(response[i].CURN).text(response[i].CompanyName);
                    $('#ddlAccountList').append(opt);
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

function getAccountPassword(ddlValue) {

    $.ajax({
        url: '/api/ddlAccountList?companyID=' + ddlValue,
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "") {
                $("#txtCompanyURLLink").val("");
                var tarURL = "https://apps.iblowthewhistle.com/Pages/Default.aspx?" + response.CompanyKey + "/ib" + response.CompanyValue;
                $("#txtCompanyURLLink").val(tarURL);

            }

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}