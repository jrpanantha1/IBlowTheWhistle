$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        GetCasePreActionMaster();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
});
function updatePreferredLanguage() {
    var preferredZone = $('#eventsCalTimezone').text();

    var languserData =
    {
        "PreferredLanguage": sessionStorage.getItem("iBlowLanguage") != null ? sessionStorage.getItem("iBlowLanguage") : localStorage.getItem("iBlowLanguage")
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
            if (response != "") {
                showSuccessMessage("Preferred language updated successfully.");
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