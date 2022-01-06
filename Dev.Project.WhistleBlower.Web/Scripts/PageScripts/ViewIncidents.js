$(document).ready(function () {

    //sessionStorage.getItem('accessToken')
    if (localStorage.getItem("accessToken") != null) {
        getViewIncidentLabelDetails();
        // getIncidentDetails();

        //default filter is comming from prefreances screen
        if ($("#hdnPreferredFilter").val() != "" && $("#hdnPreferredFilter").val() != "All") {
            getIncidentDetailsByIncCategory($("#hdnPreferredFilter").val());
            $('#dropdownFilter').text($("#hdnPreferredFilter").val());
        }
        else {
            getIncidentDetails();
            $('#dropdownFilter').text("All");
        }




        $('.signIn').hide();
        //$('.dt-buttons').find('span').prepend('<img src="/Image/ExcelIcon.png"/>')



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

    $(".target").change(function () {
        CategorySelectedEvent();
    });

});

var JsonObj = [];
function getIncidentDetails() {
    JsonObj = [];
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
                    var tarURL = "https://apps.iblowthewhistle.com/Pages/Default.aspx?" + response.objCompanyMasters.CompanyKey + "/ib" + response.objCompanyMasters.CompanyValue;
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
                    "language": { search: '', searchPlaceholder: "Search.." },
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
                    },
                    {
                        extend: 'pdf',
                        text: '<img src="/Images/ExportPDF.png"></img>',
                        titleAttr: 'Save as PDF',
                        title: 'Whistle Blow Incidents',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
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
                                if (data.rIncCategory == 'null' || data.rIncCategory == null || data.rIncCategory == "Unread") {
                                    readStatus = 1;
                                }

                                if (data.hisCount == "0") {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                else {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                var $select;
                                if (localStorage.getItem("AcctType") == "Admin") {

                                    if (data.rIncCategory != null && data.rIncCategory != "") {


                                        $select = $("<select id='" + data.rTranID + "' class='target' ></select>", {
                                        });

                                        var v = "Unread";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Read";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Important";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);
                                        v = "Done";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Discarded";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Route to email";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);


                                        //ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        //    "<option value='Unread'>Unread</option>" +
                                        //    "<option value='Read'>Read</option>" +
                                        //    "<option value='Important'>Important</option>" +
                                        //    "<option value='Done'>Done</option>" +
                                        //    "<option value='Discarded'>Discarded</option>" +
                                        //    "<option value='Route to email'>Route to email</option>" +
                                        //    "</select>";

                                        //$('#' + data.rTranID + ' option[value="' + data.rIncCategory + '"]').attr("selected", "selected");
                                        //$('#' + data.rTranID).val(data.rIncCategory);
                                        ////$('#' + data.rTranID).attr("selected", "selected");
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
                                }
                                else {

                                    ReturnHTML = " <label id='" + data.rTranID + "'>" + data.rIncCategory + "</label>";
                                    return ReturnHTML;
                                }

                                return $select.prop("outerHTML");
                            }
                        }


                    ]

                });

                $('#tblViewIncidents_filter input').addClass("searchIn");
                var tblDT = $('#tblViewIncidents').DataTable();
                if (localStorage.getItem("AcctType") != "Admin") {

                    $('.companyURLSection').hide();
                    //tblDT.button(0).enable(false);
                    $('.dt-buttons').hide();

                    //disable category colum
                    // tblDT.column(13).visible(false);
                    //disbale company code
                    $('.companyCode').hide();
                    // $('.topBanner').hide();
                }
                else {
                    //if freemium then disbale
                    if ($('#hdnSusPlanCode').val() == "1") {
                        //tblDT.buttons().disable();
                        $('.dt-buttons').hide();
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

function CategorySelectedEvent() {
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
                //location.reload();
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
                    var tarURL = "https://apps.iblowthewhistle.com/Pages/Default.aspx?" + response.objCompanyMasters.CompanyKey + "/ib" + response.objCompanyMasters.CompanyValue;
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
                    "async": false,
                    "bDestroy": true,

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
                    },
                    {
                        extend: 'pdf',
                        text: '<img src="/Images/ExportPDF.png"></img>',
                        titleAttr: 'Save as PDF',
                        title: 'Whistle Blow Incidents',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                        }
                    }],
                    "iDisplayLength": 10,
                    "language": { search: '', searchPlaceholder: "Search.." },
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
                                if (data.rIncCategory == 'null' || data.rIncCategory == null || data.rIncCategory == "Unread") {
                                    readStatus = 1;
                                }

                                if (data.hisCount == "0") {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                else {
                                    if (localStorage.getItem("AcctType") != "Admin") {
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a></div>";
                                    }
                                    else
                                        ReturnHTML = "<div><a  href='/Pages/ViewForm.aspx?iURN=" + data.rTranID + "&vs=" + readStatus + "' data-toggle='tooltip' data-placement='bottom' data-original-title='View Details'><i class='icon-link-2 mx-1'></i></a> <a target='_blank' href='Response.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Response History'><i class='icon-message-circle mx-2'></i><span style='display: inline;' class='badge badge-danger rounded-circle font-weight-normal' >" + data.hisCount + "</span></a><a target='_blank' href='Casemanagement.aspx?iURN=" + data.rTranID + "'' class='text-success' class='text-success' data-toggle='tooltip' data-placement='bottom' data-original-title='Case History'><i class='icon-briefcase mx-2'></i></a></div>";
                                }
                                return ReturnHTML;
                            }


                        },
                        {
                            "data": function (data, type, row, meta) {
                                var ReturnHTML = '';
                                var $select;
                                if (localStorage.getItem("AcctType") == "Admin") {
                                    if (data.rIncCategory != null && data.rIncCategory != "") {


                                        $select = $("<select id='" + data.rTranID + "' class='target' ></select>", {
                                        });

                                        var v = "Unread";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Read";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Important";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);
                                        v = "Done";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Discarded";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);

                                        v = "Route to email";
                                        var $option = $("<option></option>", {
                                            "text": v,
                                            "value": v
                                        });
                                        if (data.rIncCategory === v) {
                                            $option.attr("selected", "selected")
                                        }

                                        $select.append($option);


                                        //ReturnHTML = "<select id='" + data.rTranID + "' name='status' class='target'>" +
                                        //    "<option value='Unread'>Unread</option>" +
                                        //    "<option value='Read'>Read</option>" +
                                        //    "<option value='Important'>Important</option>" +
                                        //    "<option value='Done'>Done</option>" +
                                        //    "<option value='Discarded'>Discarded</option>" +
                                        //    "<option value='Route to email'>Route to email</option>" +
                                        //    "</select>";

                                        //$('#' + data.rTranID + ' option[value="' + data.rIncCategory + '"]').attr("selected", "selected");
                                        //$('#' + data.rTranID).val(data.rIncCategory);
                                        ////$('#' + data.rTranID).attr("selected", "selected");
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
                                }
                                else {

                                    ReturnHTML = " <label id='" + data.rTranID + "'>" + data.rIncCategory + "</label>";
                                    return ReturnHTML;

                                }

                                return $select.prop("outerHTML");
                                // return ReturnHTML;
                            }
                        }


                    ]

                });
                //$('#tblViewIncidents_filter input').attr("placeholder", "Search for users");
                // $('#tblViewIncidents_filter input').css("background-image", "url('/Images/ExcelIcon.png')");
                $('#tblViewIncidents_filter input').addClass("searchIn");
                //$('#tblViewIncidents_filter label').attr("text", "")

                var tblDT = $('#tblViewIncidents').DataTable();
                if (localStorage.getItem("AcctType") != "Admin") {

                    $('.companyURLSection').hide();
                    //tblDT.button(0).enable(false);
                    $('.dt-buttons').hide();

                    //disable category colum
                    //tblDT.column(13).visible(false);
                    //disbale company code
                    $('.companyCode').hide();
                    // $('.topBanner').hide();
                }
                else {
                    //if freemium then disbale
                    if ($('#hdnSusPlanCode').val() == "1") {
                        //tblDT.buttons().disable();
                        $('.dt-buttons').hide();
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




                $("#tblViewIncidents").on("change", ".target", function () {

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
                                //location.reload();
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
                //location.reload();
                $('#tblViewIncidents').DataTable().clear().destroy();
                //$('#tblViewIncidents').DataTable().clear();
                //$('#tblViewIncidents').DataTable().destroy();
                getIncidentDetails();

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


    var lanCode = getLangCode();
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
                //$('#hdnCopiedText').val(response[0].CopiedText);
                $('#hdnCopiedText').val("");
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

function sendRoueToEmail(selectedRowID) {

    var incID = selectedRowID;
    var loggedUser = $('#hdnLoggedUserName').val().trim();
    var routeData =
    {
        "hLink": "https://apps.iblowthewhistle.com/Pages/ViewForm.aspx?iURN=" + incID,
        "SenderName": loggedUser
    }


    $.ajax({
        url: '/api/Exchange?IncID=' + incID + '',
        type: "POST",
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        data: JSON.stringify(routeData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {
            showSuccessMessage("Incident details emailed successfully.");
        },
        error: function (response) {

            alert(response.responseText);
        },
        failure: function (response) {
            alert(response.responseText);
        },

    });

}

function loadFormDetailsByIURN(iURN) {

    $.ajax({
        url: '/api/ManageIncidents?IURN=' + iURN,
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            //Incidents details section start 
            if (response.IncDetails != null) {


                IncResponse = response.IncDetails;

                $('.spaTraxID').text(IncResponse.IURN);
                $('.spaTraxDate').text(IncResponse.SubmissionDateTime.toLocaleString());

                $('#IsReportable').val(IncResponse.IsReportable == true ? "Yes" : "No");

                $('#HaveWitness').val(IncResponse.HaveWitness == true ? "Yes" : "No");
                IncResponse.HaveWitness == true ? $('#collapseHaveWitness').show() : $('#collapseHaveWitness').hide();
                $('#FileAttachment').val(IncResponse.FileAttachment == true ? "Yes" : "No");
                $('#UpdatedOnIncident').val(IncResponse.UpdatedOnIncident == true ? "Yes" : "No");
                IncResponse.UpdatedOnIncident == true ? $('#collapseUpdatedOnIncident').show() : $('#collapseUpdatedOnIncident').hide();
                $('#UpdatedOnIncidentMethod').val(IncResponse.UpdatedOnIncidentMethod == "1" ? "Email" : IncResponse.UpdatedOnIncidentMethod == "2" ? "Phone" : "Anonymous");
                $('#comments').text(IncResponse.Comments);

                if (IncResponse.SupportingEvidence == true) {
                    $('#SupportingEvidence').val("Yes");
                    $('.collapseSupportingEvidence').show();
                }
                else {
                    $('#SupportingEvidence').val("No");
                    $('.collapseSupportingEvidence').hide();
                }


                if (IncResponse.SupportingEvidence == true) {
                    $('#EvidenceDetails').text(IncResponse.EvidenceDetails);
                } else
                    $('#collapseSupportingEvidence').hide();

                $('#EvidenceCanBeUsedForInvestigation').prop('checked', true);
                $('#customCheck1').prop('checked', true);

                if (IncResponse.SupportingDocuments != null && IncResponse.SupportingDocuments != "") {

                    var filesPaths = IncResponse.SupportingDocuments;
                    var caseDocHtml = " <ol class='CaseDocfa-ul'>";

                    var arr = filesPaths.split(';');
                    for (var i = 0; i < arr.length; i++) {
                        var dd = i + 1;
                        if (arr[i] != "") {
                            var fileName1 = arr[i].substring(arr[i].lastIndexOf("/") + 1, arr[i].length);

                            caseDocHtml += "<a target='_blank' href='" + arr[i] + "' download=" + fileName1 + "><li><span class='casefa-li'><i class='icon-file-text mx-2'></i></span> " + dd + " - " + fileName1 + "</li></a>";
                            //$('#divAttachements').append("<a target='_blank' href=" + arr[i] + " download=" + fileName1 + "> " + fileName1 + "</a></br>");
                        }
                    }
                    caseDocHtml += "</ol >";
                    $('#divAttachements').append(caseDocHtml);


                }
                //else
                //$('.avatar').attr("style", "display:none")

                if (localStorage.getItem("AcctType") != "Admin") {
                    if (IncResponse.ReportedLanguageID != "") {
                        sessionStorage.setItem("iBlowLanguage", IncResponse.ReportedLanguageID);
                        changeSelectedLanguageonBar(IncResponse.ReportedLanguageID);
                        getLabelDetails();
                    }
                }

            }
            //Witness details section start here
            if (response.witnessColn != null) {
                for (var i = 0; i < response.witnessColn.length; i++) {
                    if (i == 0) {


                        $('#WitnessFullName').val(controlIsNullCheck(response.witnessColn[i].FullName));
                        $('#WitnessEmail').val(controlIsNullCheck(response.witnessColn[i].Email));
                        $('#WitnessPhone').val(controlIsNullCheck(response.witnessColn[i].Phone));
                        disbaleWitnessControls(0, true);
                    }
                    if (i > 0) {
                        var newelement = $(".clone-witness").eq(0).clone();
                        var num = $('.clone-witness').length;
                        var newNum = num + 1;
                        newelement.find('input').each(function (i) {
                            $(this).attr('name', $(this).attr('name') + newNum);
                            $(this).attr('id', $(this).attr('id') + newNum);
                        });
                        newelement.find('label').each(function (i) {
                            $(this).attr('id', $(this).attr('id') + newNum);
                        });
                        //newelement.append('<div class="form-group"><button class="btn btn-sm btn-block btn-danger btn-remove" type="button"><i class="icon-minus"></i> Remove this witness</button></div>')
                        $('.clone-witness').last().after(newelement);
                        var tempNumber = i + 1;

                        disbaleWitnessControls(tempNumber, true);
                        $('#WitnessFullName' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].FullName));
                        $('#WitnessEmail' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].Email));
                        $('#WitnessPhone' + tempNumber).val(controlIsNullCheck(response.witnessColn[i].Phone));
                    }

                }
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