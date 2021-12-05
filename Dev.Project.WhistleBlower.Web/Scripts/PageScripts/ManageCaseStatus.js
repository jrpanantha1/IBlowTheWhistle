
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

var JsonPreCaseObj = [];
function GetCasePreActionMaster() {

    var lanCode = 1;
    if (localStorage.getItem("iBlowLanguage") != null) {
        lanCode = localStorage.getItem("iBlowLanguage").toString();
    }
    JsonPreCaseObj = [];
    $.ajax({
        url: '/api/CasePreActionMasters?langID=' + Number(lanCode),
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                var items = response;
                for (var i = 0; i < items.length; i++) {

                    JsonPreCaseObj.push({
                        "rID": i + 1,
                        "rCPURN": items[i].CPURN,
                        "rCURN": items[i].CURN,
                        "rLanguageID": items[i].LanguageID,
                        "rPreAction": items[i].PreAction,
                        "rPreActionBrief": items[i].PreActionBrief
                    });
                }

                //$('#tableCasePreAction').DataTable().clear();
                $('#tableCasePreAction').DataTable().destroy();

                $('#tableCasePreAction').DataTable({
                    "data": JsonPreCaseObj,
                    "bDestroy": true,
                    select: {
                        style: 'single'
                    },
                    language: {
                        paginate: {
                            next: '&#8594;', // or '→'
                            previous: '&#8592;' // or '←' 
                        }
                    },
                    "bProcessing": true,
                    "columnDefs": [
                        { targets: [0, 4, 5], visible: true },
                        { targets: '_all', visible: false }
                    ],
                    "iDisplayLength": 10,
                    "aoColumns": [
                        { "data": "rID" },
                        { "data": "rCPURN" },
                        { "data": "rCURN" },
                        { "data": "rLanguageID" },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                ReturnHTML = "<div class='gridDescription wd200'>" + data.rPreAction + "</div>"
                                return ReturnHTML;
                            }
                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                ReturnHTML = "<div class='gridDescription wd200'>" + data.rPreActionBrief + "</div>"
                                return ReturnHTML;
                            }
                        }
                    ]
                });

                var table = $('#tableCasePreAction').DataTable();
                $('#tableCasePreAction tbody').on('click', 'tr', function () {

                    if ($(this).hasClass('selected')) {
                        $(this).removeClass('selected');
                    }
                    else {
                        table.$('tr.selected').removeClass('selected');
                        $(this).addClass('selected');
                    }

                    var selectedData = table.rows('.selected').data();
                    //alert(selectedData[0].rPreAction);
                    $('#txtStatusCode').val(selectedData[0].rPreAction);
                    $('#txtStatusDesc').val(selectedData[0].rPreActionBrief);
                    $('#txtTranID').val(selectedData[0].rCPURN);

                });

            }
        },
        error: function (response) {
            alert(response.responseText);
            if (response.responseText.indexOf("Authorization has been denied for this request") != -1) {
                window.location.href = "/Pages/Login.aspx";
            }
        },
        failure: function (response) {
            alert(response.responseText);
        }
    });
}

function updatePreActionValidation() {
    var flag = true;

    if (!GetTextBoxEmptyValidation($('#txtStatusCode'))) {
        flag = false;
    }
    if (!GetTextBoxEmptyValidation($('#txtStatusDesc'))) {
        flag = false;
    }
    return flag;
}
function updatePreAction() {
    var sCode = $('#txtStatusCode').val();
    var sDesc = $('#txtStatusDesc').val();
    var sCPURN = $('#txtTranID').val();

    var dataCasePreAction = {
        "PreAction": sCode,
        "PreActionBrief": sDesc,
        "CPURN": sCPURN
    };

    $.ajax({
        url: '/api/CasePreActionMasters',
        method: 'PUT',
        data: JSON.stringify(dataCasePreAction),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "" && response == "Success") {
                alert("Status Code has been updated successfully.");
                //showSuccessMessage("Status Code has been updated successfully.");
                location.reload();

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
function clearControls() {
    $('#txtStatusCode').val("");
    $('#txtStatusDesc').val("");
    $('#txtTranID').val("");

}