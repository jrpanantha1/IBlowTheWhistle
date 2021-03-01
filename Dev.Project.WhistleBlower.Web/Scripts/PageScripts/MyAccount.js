
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null) {
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});

function updateCompanyProfile() {

    var companyData =
      {
          "CompanyLogo": ppBase64
      }

    $.ajax({
        url: '/api/CompanyMasters',
        method: 'POST',
        data: JSON.stringify(companyData),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        success: function (response) {
            if (response != null && response != "") {
                $('#defualtComLogo').hide();
                $('#customizedLogo').show();
                $('.companyavatar').attr("src", response)

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

var ppBase64 = "";
function readFile(file, onLoadCallback) {
    var fSize = (file.size) / 1024;
    if (fSize < 600) {
        var reader = new FileReader();
        reader.onload = onLoadCallback;
        reader.readAsDataURL(file);
    } else {
        $('.msgBox').text("Photo size max 600kb")
        $('.msgBox').show(500);

        return false;
    }
}