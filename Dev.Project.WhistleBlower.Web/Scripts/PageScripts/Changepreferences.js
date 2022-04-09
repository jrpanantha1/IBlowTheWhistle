$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});
$(function () {
    $("a.incCategoryClick").click(function () {
        var incCatSelectedText = $(this).attr('selectedtext');
        if (incCatSelectedText != "All") {
            $('#dropdownFilter').text(incCatSelectedText);
        }
        else {
            $('#dropdownFilter').text("All");
        }


    });
});


function updatePreferredLanguage() {
    var preferredZone = $('#eventsCalTimezone').text();
    var prefferedFilter = $('#dropdownFilter').text();
    var languserData =
    {
        "PreferredLanguage": sessionStorage.getItem("iBlowLanguage") != null ? sessionStorage.getItem("iBlowLanguage") : localStorage.getItem("iBlowLanguage"),
        "PreferredFilter": prefferedFilter
    }

    $.ajax({
        url: '/api/RegisteredUsers',
        method: 'PUT',
        data: JSON.stringify(languserData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != "Unauthorized") {
                showSuccessMessage("Preferences updated successfully.");
            }
            else {
                alert(response);
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

function updateAdminNotification() {

    var chkValue = $('.switch-input').prop('checked');

    var companyData =
    {
        "SendAdmNotifyOnNewCase": chkValue
    }

    $.ajax({
        url: '/api/CompanyMasters',
        method: 'PUT',
        data: JSON.stringify(companyData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response != "") {
                showSuccessMessage("Admin notification updated successfully.");
            }
            else {
                showSuccessMessage("Error occured. Please contact admin support.");
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

 