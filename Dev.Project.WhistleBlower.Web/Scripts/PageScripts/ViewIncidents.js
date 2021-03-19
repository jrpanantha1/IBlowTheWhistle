$(document).ready(function () {

    //sessionStorage.getItem('accessToken')
    if (localStorage.getItem("accessToken") != null) {
        getIncidentDetails();
        $('.signIn').hide();
        $('.dt-buttons').find('span').prepend('<img src="/Image/ExcelIcon.png"/>')


    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }


    menuEnableDisable();//ref Utility.js


});

var JsonObj = [];
function getIncidentDetails() {

    $.ajax({
        url: '/api/ManageIncidents',
        cache: false,
        type: "GET",
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //async: false,

        success: function (response) {

            if (response != null && response != "") {

                $("#divUserTable").show();

                if (response.objCompanyMasters != null) {

                    $("#spanCompany").text(response.objCompanyMasters.CompanyName);
                    $(".spanCompanyNameIcon").text(response.objCompanyMasters.CompanyName);
                    $("#spanCode").text(response.CompanyValueNonEncrypt);
                    var tarURL = "https://iblowthewhistle.com/Pages/Home.aspx?" + response.objCompanyMasters.CompanyKey + "/ib" + response.objCompanyMasters.CompanyValue;
                    $("#txtCompanyLink").val(tarURL);


                    if (localStorage.getItem("AcctType") == "Admin") {

                        if (response.CompantTopBanners != null && response.CompantTopBanners != "") {
                            $('.imgTopBanner').attr("src", response.CompantTopBanners);
                        }
                        else {
                            $('.imgTopBanner').attr("src", "/assets/images/Whistle_728x90_Internalbanner.PNG");
                        }
                        $('.ancImgTopBanner').attr("href", tarURL);

                    }


                    //else { $('.companyURLSection').show() }
                    $('.companyURLSection').show();


                }

                var items = response.objWhistleBlowIncidents;

                for (var i = 0; i < items.length; i++) {
                    var sDate = new Date(items[i].SubmissionDateTime).toLocaleString();//new Date(items[i].SubmissionDateTime).format("dd/MM/yyyy hh:mm tt");
                    JsonObj.push({
                        "rID": i + 1,
                        "rTranID": items[i].IURN,
                        "rEvidenceDetails": items[i].EvidenceDetails,
                        "rComments": items[i].Comments,
                        "rRepotable": items[i].IsReportable == true ? "Yes" : "No",
                        "rSupDocuments": items[i].SupportingEvidence == true ? "Yes" : "No",
                        "rHaveWitness": items[i].HaveWitness == true ? "Yes" : "No",
                        "rUpdatePro": items[i].UpdatedOnIncident == true ? "Yes" : "No",
                        "rContactEmail": items[i].Email,
                        "rContactPhone": items[i].Phone,
                        "rAnonymousEmail": items[i].AnonymousEmailID,
                        "rSubmissionDateTime": sDate,
                        "hisCount": items[i].HistoryCount,
                        "rIncCategory": items[i].IncCategory
                    });
                }

                //$('#tblViewIncidents').DataTable().bDestroy();
                //$('#tblViewIncidents tbody').empty();

                $('#tblViewIncidents').DataTable({
                    "data": JsonObj,
                    "bDestroy": true,
                    "bProcessing": true,
                    "columnDefs": [
                        { targets: [0, 2, 3, 11, 12, 13], visible: true },
                        { targets: '_all', visible: false }
                    ],
                    dom: 'Bfrtip',
                    buttons: [{
                        extend: 'excel',
                        title: 'Whistle Blow Incidents',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                        }
                    }],
                    "iDisplayLength": 10,
                    "aoColumns": [
                        { "data": "rID" },
                        { "data": "rTranID" },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                ReturnHTML = "<div class='gridDescription wd100'>" + data.rEvidenceDetails + "</div>"
                                return ReturnHTML;
                            }
                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                ReturnHTML = "<div class='gridDescription wd100'>" + data.rComments + "</div>"
                                return ReturnHTML;
                            }


                        },
                        { "data": "rRepotable" },
                        { "data": "rSupDocuments" },
                        { "data": "rHaveWitness" },
                        { "data": "rUpdatePro" },
                        { "data": "rContactEmail" },
                        { "data": "rContactPhone" },
                        { "data": "rAnonymousEmail" },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                ReturnHTML = data.rSubmissionDateTime;
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                // <a href="chat.html" class="text-success" class="text-success" data-toggle="tooltip" data-placement="top" data-original-title="Chat History"><i class="icon-message-circle mx-2"></i></a>
                                if (data.hisCount == "0") {
                                    ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>"
                                }
                                else {
                                    ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>"
                                }
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                if (data.rIncCategory != null && data.rIncCategory != "") {

                                    ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        "<option value='Unread'>Unread</option>" +
                                        "<option value='Read'>Read</option>" +
                                        "<option value='Important'>Important</option>" +
                                        "<option value='Done'>Done</option>" +
                                        "<option value='Discarded'>Discarded</option>" +
                                        "<option value='Routetoemail'>Route to email</option>" +
                                        "</select>";
                                    $('#' + data.rTranID).val(data.rIncCategory);
                                }
                                else {
                                    ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        "<option value='Unread'>Unread</option>" +
                                        "<option value='Read'>Read</option>" +
                                        "<option value='Important'>Important</option>" +
                                        "<option value='Done'>Done</option>" +
                                        "<option value='Discarded'>Discarded</option>" +
                                        "<option value='Routetoemail'>Route to email</option>" +
                                        "</select>";
                                }

                                return ReturnHTML;
                            }
                        }


                    ]

                });

                var tblDT = $('#tblViewIncidents').DataTable();
                if (localStorage.getItem("AcctType") != "Admin") {

                    $('.companyURLSection').hide();
                    tblDT.button(0).enable(false);
                    //disable category colum
                    tblDT.column(13).visible(false);
                    //disbale company code
                    $('.companyCode').hide();
                    $('.topBanner').hide();
                }
                else {
                    tblDT.button(0).enable(true);
                    tblDT.column(13).visible(true);
                    //enable company code
                    $('.companyCode').show();
                    $('.topBanner').show();
                }



                $(".target").change(function () {

                    var selectedID = $(this).attr("id");
                    var ddlSelectedValue = $(this).val();

                    $.ajax({
                        url: '/api/ManageIncidents?IURN=' + selectedID + '&status=' + ddlSelectedValue + '',
                        method: 'PUT',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        async: false,
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
                        },
                        success: function (response) {
                            if (response != null && response == "Success") {
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
                });

            }
            else {

            }
            //
            $('[data-toggle="tooltip"]').tooltip();

        },
        error: function (response) {
            window.location.href = "/Pages/Login.aspx";

        },
        failure: function (response) {
        },
        complete: function () {

        }
    })
}


function copyCompanyLink() {
    var copyText = document.getElementById("txtCompanyLink");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = "Copied";
}