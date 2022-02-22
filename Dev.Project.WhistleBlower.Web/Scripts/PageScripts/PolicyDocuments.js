
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        getPolicyDocuments();
        getPolicyHTML();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }

});
function getPolicyDocuments() {

    $.ajax({
        url: '/api/PolicyDocument',
        method: 'GET',
        async: false,
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                var caseDocHtml = "";
                $('#divCaseDocuments').empty();

                var arrFile = response.split(';');

                //caseDocHtml = "<ul class='list - group list - group - flush'>";
                caseDocHtml = " <ol class='CaseDocfa-ul'>";

                for (var i = 0; i < arrFile.length; i++) {
                    var dRow = i + 1;
                    if (arrFile[i] != null && arrFile[i] != "") {

                        var last = arrFile[i].substring(arrFile[i].lastIndexOf("/") + 1, arrFile[i].length);

                        caseDocHtml += "<a target='_blank' href='" + arrFile[i] + "'><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dRow + " - " + last + "<i sValue='" + arrFile[i] + "' id='icon-trash-2' style='float:right;padding:5px;' class='icon-trash-2 mx-2'></i></li></a>";
                    }
                }
                caseDocHtml += "</ol >";

            }
            $('#divCaseDocuments').append(caseDocHtml);

        },
        error: function (response) {

        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}
function uploadPolicyDocuments() {

    if (PolicyDocumentValidation()) {
        return false;
    }
    var data = new FormData();
    jQuery.each(jQuery('#FileAttachmentDetails')[0].files, function (i, file) {
        data.append('file-' + i, file);
    });

    $.ajax({
        type: "POST",
        url: '/api/PolicyDocument',
        enctype: 'multipart/form-data',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: false,
        processData: false,
        cache: false,
        data: data,
        success: function (data, textStatus, xhr) {
            $("#FileAttachmentDetails").val(null);
            getPolicyDocuments();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });


}
function updatePolicy() {
    var postVal = $('#summernote').summernote('code');//$('#txtPost').val();
    if ($('#summernote').summernote('isEmpty')) {
        return false;
    }

    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    var objPolicy = {
        "PolicyHTML": postVal,
        "LanguageID": lanCode
    };

    $.ajax({
        url: '/api/PolicyMasters',
        method: 'POST',
        data: JSON.stringify(objPolicy),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
                getPolicyHTML();
                $('#summernote').summernote('reset');
                showSuccessMessage("Policy has been updated successfully.");
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

function getPolicyHTML() {
    var lanCode = 1;
    if ((sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "") || localStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage") != null && sessionStorage.getItem("iBlowLanguage") != "" ? sessionStorage.getItem("iBlowLanguage").toString() : localStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/PolicyMasters?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#divCaseHtmContents').append(response[0].PolicyHTML);

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
//delete documents
$(document).ready(function () {
    $(document).on('click', '#icon-trash-2',
        function () {

            var listValue = $(this).parent().parent().attr('href');
            if (confirm("Are you sure want to delete?")) {
                //alert(listValue);

                $.ajax({
                    url: '/api/PolicyDocument?delfilePath=' + listValue,
                    method: 'DELETE',
                    async: false,
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
                    },
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        if (response != null && response != "") {
                            getPolicyDocuments();
                        }
                    },
                    error: function (response) {

                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            }

            return false;
        });
});

function PolicyDocumentValidation() {
    var caseFileControl = $('#FileAttachmentDetails');

    if (caseFileControl.val() == null || caseFileControl.val() == "") {
        flag = false;
        caseFileControl.addClass('error');
    }
    else {
        caseFileControl.removeClass('error');
    }
}

