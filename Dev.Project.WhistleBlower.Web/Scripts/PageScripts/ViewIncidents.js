$(document).ready(function () {

    //sessionStorage.getItem('accessToken')
    if (localStorage.getItem("accessToken") != null) {
        getViewIncidentLabelDetails();
        getIncidentDetails();
        $('.signIn').hide();
        $('.dt-buttons').find('span').prepend('<img src="/Image/ExcelIcon.png"/>')


    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }


    menuEnableDisable();//ref Utility.js


    $(".incCategoryClick").click(function (e) {
        e.preventDefault();
        var incCatSelectedText = $(this).attr('selectedtext');

        if (incCatSelectedText != "All") {
            getIncidentDetailsByIncCategory(incCatSelectedText);
        }
        else {
            $('#tblViewIncidents').DataTable().clear();
            $('#tblViewIncidents').DataTable().destroy();
            getIncidentDetails();
        }
        $('#dropdownFilter').text(incCatSelectedText);


    });

});

var JsonObj = [];
function getIncidentDetails() {
    JsonObj = []
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
                    $("#spanCode").val(response.CompanyValueNonEncrypt);
                    var tarURL = "https://iblowthewhistle.com/Pages/Default.aspx?" + response.objCompanyMasters.CompanyKey + "/ib" + response.objCompanyMasters.CompanyValue;
                    $("#txtCompanyLink").val(tarURL);


                    //if (localStorage.getItem("AcctType") == "Admin") {
                    //}

                    //show top banner if available
                    if (response.CompantTopBanners != null && response.CompantTopBanners != "") {
                        $('.imgTopBanner').attr("src", response.CompantTopBanners);
                    }
                    else {
                        $('.imgTopBanner').attr("src", "/assets/images/WhistleDefaultTopBanner.PNG");
                    }
                    $('.ancImgTopBanner').attr("href", tarURL);
                    $('.topBanner').show();
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
                    language: {
                        paginate: {
                            next: '&#8594;', // or '→'
                            previous: '&#8592;' // or '←' 
                        }
                    },
                    "bProcessing": true,
                    "columnDefs": [
                        { targets: [0, 3, 11, 12, 13], visible: true },
                        { targets: '_all', visible: false }
                    ],
                    dom: 'Bfrtip',
                    buttons: [{
                        extend: 'excel',
                        text: '<img src="/Images/ExcelIcon.png"></img>',
                        titleAttr: 'Save as Excel',
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
                                var readStatus = 0;
                                if (data.rIncCategory == 'null' || data.rIncCategory == null) {
                                    readStatus = 1;
                                }

                                if (data.hisCount == "0") {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnViewDetails').val() + "'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnResHistory').val() + "'><i class='icon-message-circle mx-2'></i></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnViewDetails').val() + "'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnResHistory').val() + "'><i class='icon-message-circle mx-2'></i></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnCaseMngt').val() + "'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                else {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnViewDetails').val() + "'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnResHistory').val() + "'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnViewDetails').val() + "'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnResHistory').val() + "'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='" + $('#hdnCaseMngt').val() + "'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                if (data.rIncCategory != null && data.rIncCategory != "") {

                                    ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        "<option class='incidenttype1' value='Unread'>&#128387; Unread</option>" +
                                        "<option class='incidenttype2' value='Read'>&#128065 Read</option>" +
                                        "<option class='incidenttype3' value='Important'>&#9734; Important</option>" +
                                        "<option class='incidenttype4' value='Done'>&#9745; Done</option>" +
                                        "<option class='incidenttype5' value='Discarded'>&#128498; Discarded</option>" +
                                        "<option class='incidenttype6' value='Route to email'>&#9993; Route to email</option>" +
                                        "</select>";
                                    $('#' + data.rTranID).val(data.rIncCategory);
                                }
                                else {
                                    ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        "<option class='incidenttype1' value='Unread'>&#128387; Unread</option>" +
                                        "<option  class='incidenttype2' value='Read'>Read</option>" +
                                        "<option  class='incidenttype3' value='Important'>&#9734; Important</option>" +
                                        "<option  class='incidenttype4' value='Done'>&#9745; Done</option>" +
                                        "<option  class='incidenttype5' value='Discarded'>&#128498; Discarded</option>" +
                                        "<option  class='incidenttype6' value='Route to email'>&#9993; Route to email</option>" +
                                        "</select>";
                                }

                                //ReturnHTML = " <div class='statusmenu'><details class='details - example'><summary> <p id='incidentstatus - active' class='activestatus'>Select</p> </summary>" +
                                //    " <ul id='incidentstatus - list'>" +
                                //    "<li class='statunread' data-value='Unread' data-class='activestatus1'>Unread</li>" +
                                //    "<li class='statread' data-value='Read' data-class='activestatus2'>Read</li>" +
                                //    "<li class='statimp' data-value='Important' data-class='activestatus3'>Important</li>" +
                                //    "<li class='statdone' data-value='Done' data-class='activestatus4'>Done</li>" +
                                //    "<li class='statdisc' data-value='Discarded' data-class='activestatus5'>Discarded</li>" +
                                //    "<li class='statrtm' data-value='Route to Mail' data-class='activestatus6'>Route to Mail</li>" +

                                //    "</ul></details> </div> </div> </div>";

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
                    // $('.topBanner').hide();
                }
                else {
                    //if freemium then disbale. 
                    // now no more freemium so enabling the column
                    //if ($('#hdnSusPlanCode').val() == "1") {
                    //    tblDT.buttons().disable();
                    //    tblDT.column(13).visible(false);// category coln

                    //}
                    //else {
                    //    tblDT.column(13).visible(true);
                    //}

                    //tblDT.button(0).enable(true);

                    //enable company code
                    $('.companyCode').show();
                    //$('.topBanner').show();
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
                                updateCaseInformationOnStatusChange(selectedID, ddlSelectedValue);
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

function getIncidentDetailsByIncCategory(incCategory) {
    JsonObj = [];
    $.ajax({
        url: '/api/ManageIncidents?IncCategory=' + incCategory + '&SearchID="1"',
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
                    $("#spanCode").val(response.CompanyValueNonEncrypt);
                    var tarURL = "https://iblowthewhistle.com/Pages/Default.aspx?" + response.objCompanyMasters.CompanyKey + "/ib" + response.objCompanyMasters.CompanyValue;
                    $("#txtCompanyLink").val(tarURL);


                    //if (localStorage.getItem("AcctType") == "Admin") {
                    //}

                    //show top banner if available
                    if (response.CompantTopBanners != null && response.CompantTopBanners != "") {
                        $('.imgTopBanner').attr("src", response.CompantTopBanners);
                    }
                    else {
                        $('.imgTopBanner').attr("src", "/assets/images/WhistleDefaultTopBanner.PNG");
                    }
                    $('.ancImgTopBanner').attr("href", tarURL);
                    $('.topBanner').show();
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

                $('#tblViewIncidents').DataTable().clear();
                $('#tblViewIncidents').DataTable().destroy();

                $('#tblViewIncidents').DataTable({
                    "data": JsonObj,
                    "bDestroy": true,
                    "bProcessing": true,
                    "columnDefs": [
                        { targets: [0, 3, 11, 12, 13], visible: true },
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
                                var readStatus = 0;
                                if (data.rIncCategory == 'null' || data.rIncCategory == null) {
                                    readStatus = 1;
                                }

                                if (data.hisCount == "0") {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                else {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a target='_blank' href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
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
                                        "<option value='Route to email'>Route to email</option>" +
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
                                        "<option value='Route to email'>Route to email</option>" +
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
                    // $('.topBanner').hide();
                }
                else {
                    //if freemium then disbale
                    if ($('#hdnSusPlanCode').val() == "1") {
                        tblDT.buttons().disable();
                        tblDT.column(13).visible(false);// category coln

                    }
                    else {
                        tblDT.column(13).visible(true);
                    }

                    //tblDT.button(0).enable(true);

                    //enable company code
                    $('.companyCode').show();
                    //$('.topBanner').show();
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
                                updateCaseInformationOnStatusChange(selectedID, ddlSelectedValue);
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

function updateCaseInformationOnStatusChange(iurn, SelectedValue) {

    var loggedUser = $('#hdnLoggedUserName').val().trim();
    var textFormation = "Status changed by {" + loggedUser + "} to " + SelectedValue

    //var dataResponse = {
    //    "CaseInformation": "Case status changed to " + SelectedValue,
    //    "IURN": iurn
    //};

    var dataResponse = {
        "CaseInformation": textFormation,
        "IURN": iurn
    };

    $.ajax({
        url: '/api/CaseManagements',
        method: 'POST',
        data: JSON.stringify(dataResponse),
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (response) {
            if (response != null && response != "") {
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

function copyCompanyLink() {
    var copyText = document.getElementById("txtCompanyLink");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipPass");
    tooltip.innerHTML = $('#hdnCopiedText').val();

}
function copyCompanyCode() {
    var copyText = document.getElementById("spanCode");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    var tooltip = document.getElementById("myTooltipComCode");
    tooltip.innerHTML = $('#hdnCopiedText').val();

}

function getViewIncidentLabelDetails() {


    var lanCode = 1;
    if (sessionStorage.getItem("iBlowLanguage") != null) {
        lanCode = sessionStorage.getItem("iBlowLanguage").toString();
    }

    $.ajax({
        url: '/api/ViewIncidentsLanguages?langID=' + lanCode,
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                $('#companyNamelbl').text(response[0].CompanyNameTitle);
                $('#companyCodelbl').text(response[0].CompanyCodeTitle);
                $('#companyURLlbl').text(response[0].CompanyURLTitle);
                $('#spanConcernDetailsGrd').text(response[0].ConcernDetailGrid);
                $('#spanSubDateGrd').text(response[0].SubDateGrid);
                $('#spanActionGrd').text(response[0].ActionGrid);
                $('.cbtooltiptextOriginal').attr("data-original-title", response[0].CopyLinkHere);
                $('#hdnCopiedText').val(response[0].CopiedText);
                $('#hdnViewDetails').val(response[0].TipViewDetails);
                $('#hdnResHistory').val(response[0].TipResponseHistory);
                $('#hdnCaseMngt').val(response[0].TipCaseMngt);
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