
$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        GetSubscriptionHistory();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }
  

});

var JsonSubHistory = [];
function GetSubscriptionHistory() {

    JsonSubHistory = [];
    $.ajax({
        url: '/api/SubscriptionHistroys',
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

                    JsonSubHistory.push({
                        "rID": i + 1,
                        "rInvoiceNo": items[i].SubInvoiceNo,
                        "rPlanType": items[i].SubscriptionPlan,
                        "rValidTo": new Date(items[i].ValidTo).toLocaleString(),
                        "rCurrency": items[i].Currency,
                        "rAmount": items[i].Amount,
                        "rPaidVia": items[i].PaidVia,
                        "rSubStatus": items[i].SubStatus,
                        "rSubscribedOn": new Date(items[i].Created).toLocaleString()
                    });
                }


                $('#tableSubscrionHistory').DataTable({
                    "data": JsonSubHistory,
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
                        { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8], visible: true },
                        { targets: '_all', visible: false }
                    ],
                    "iDisplayLength": 10,
                    "aoColumns": [
                        { "data": "rID" },
                        { "data": "rInvoiceNo" },
                        { "data": "rPlanType" },
                        { "data": "rValidTo" },
                        { "data": "rCurrency" },
                        { "data": "rAmount" },
                        { "data": "rPaidVia" },
                        { "data": "rSubStatus" },
                        { "data": "rSubscribedOn" }
                    ]
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
