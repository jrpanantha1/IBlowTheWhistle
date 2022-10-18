
$(document).ready(function () {
    onload();
    $('#txtName').focus();
});

function onSubmit(token) {
    AddNewAssesment();
}

function validate(event) {
    event.preventDefault();
    if (!assesmentSectionValidation()) {

    } else {
        grecaptcha.execute();
    }
}
function onload() {
    var element = document.getElementById('btnSubmit');
    element.onclick = validate;
}

function Confirmation() {
    AddNewAssesment();
}

function AddNewExaminorValidation() {
    var flag = true;
    var focusElm = "";
    if (!GetTextBoxEmptyValidation($('#txtName'))) {
        flag = false;
        focusElm = '#txtName';
    }
    else {
        if (!GetTextLengthValidation($('#txtName'), 50)) {
            flag = false;
            focusElm = '#txtName';
        }
    }

    if (!GetTextBoxEmptyValidation($('#txtEmail'))) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#txtEmail';
        }
    } else {
        if (!ValidateEmail($('#txtEmail'))) {
            flag = false;
            if (focusElm == "") {
                focusElm = '#txtEmail';
            }
        }
        else if (!GetTextLengthValidation($('#txtEmail'), 50)) {
            flag = false;
            focusElm = '#txtEmail';
        }
    }

    if (!GetTextLengthValidation($('#txtOrganisation'), 100)) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#txtEmail';
        }
    }

    if (!GetTextLengthValidation($('#txtRole'), 50)) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#txtRole';
        }
    }

    if (!GetTextLengthValidation($('#txtPhone'), 15)) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#txtPhone';
        }
    }

    if (!flag) {
        $(focusElm).focus();
    }

    return flag;
}
function assesmentBeginValidation() {

    var flag = true;

    if (!GetRadioButtonGroupEmptyValidation("Whistleblowing")) {
        flag = false;
        $('#rdbcorruption').focus();
    }

    return flag;

}
function assesmentSectionValidation() {

    var flag = true;
    var focusElm = "";

    //section 1
    if (!GetRadioButtonGroupEmptyValidation("WBpolicy")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes1';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("responsibility")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes2';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("communicated")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbStaff';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("contractors")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes3';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("confidentiality")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes4';
        }
    }
    //section 2
    if (!GetRadioButtonGroupEmptyValidation("champion")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes11';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("autonomy")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes22';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("trained")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes33';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("whistleblower")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes44';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("receive")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbNothing';
        }
    }
    //Section 3
    if (!GetRadioButtonGroupEmptyValidation("speak")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbRating1';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("anonymous")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes111';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("retaliation")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes222';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("independent")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbYes333';
        }
    }
    if (!GetRadioButtonGroupEmptyValidation("encourage")) {
        flag = false;
        if (focusElm == "") {
            focusElm = '#rdbDefinitely';
        }
    }

    if (!flag) {
        $(focusElm).focus();
    }
    return flag;


}
function showAssessment() {
    $("#divUserDetails").hide();
    $("#divQuestionaire").show();
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}
function BeginAssessment() {
    $("#divUserDetails").hide();
    $("#divQuestionaire").hide();
    $("#divAssesmentDetails").show();
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}
function constructAssesmentResult() {


    var ResultArray = [];

    //Question 0
    var category1 = "TRUST";
    var strQuestion0 = $("#pQ0").text();
    var strAns0 = $('input[name="Whistleblowing"]:checked').val();
    ResultArray.push({ Question: strQuestion0, GivenAns: strAns0, Category: category1 });

    //Question 1
    var strQuestion1 = $("#pQ1").text();
    var strAns1 = $('input[name="WBpolicy"]:checked').val();
    ResultArray.push({ Question: strQuestion1, GivenAns: strAns1, Category: category1 });

    //Question 2
    var strQuestion2 = $("#pQ2").text();
    var strAns2 = $('input[name="responsibility"]:checked').val();
    ResultArray.push({ Question: strQuestion2, GivenAns: strAns2, Category: category1 });

    //Question 3
    var strQuestion3 = $("#pQ3").text();
    var strAns3 = $('input[name="communicated"]:checked').val();
    ResultArray.push({ Question: strQuestion3, GivenAns: strAns3, Category: category1 });

    //Question 4
    var strQuestion4 = $("#pQ4").text();
    var strAns4 = $('input[name="contractors"]:checked').val();
    ResultArray.push({ Question: strQuestion4, GivenAns: strAns4, Category: category1 });

    //Question 5
    var strQuestion5 = $("#pQ5").text();
    var strAns5 = $('input[name="confidentiality"]:checked').val();
    ResultArray.push({ Question: strQuestion5, GivenAns: strAns5, Category: category1 });

    //Question 6
    var category2 = "IMPARTIALITY";
    var strQuestion6 = $("#pQ6").text();
    var strAns6 = $('input[name="champion"]:checked').val();
    ResultArray.push({ Question: strQuestion6, GivenAns: strAns6, Category: category2 });

    //Question 7
    var strQuestion7 = $("#pQ7").text();
    var strAns7 = $('input[name="autonomy"]:checked').val();
    ResultArray.push({ Question: strQuestion7, GivenAns: strAns7, Category: category2 });

    //Question 8
    var strQuestion8 = $("#pQ8").text();
    var strAns8 = $('input[name="trained"]:checked').val();
    ResultArray.push({ Question: strQuestion8, GivenAns: strAns8, Category: category2 });

    //Question 9
    var strQuestion9 = $("#pQ9").text();
    var strAns9 = $('input[name="whistleblower"]:checked').val();
    ResultArray.push({ Question: strQuestion9, GivenAns: strAns9, Category: category2 });

    //Question 10
    var strQuestion10 = $("#pQ10").text();
    var strAns10 = $('input[name="receive"]:checked').val();
    ResultArray.push({ Question: strQuestion10, GivenAns: strAns10, Category: category2 });

    //Question 11
    var category3 = "PROTECTION";
    var strQuestion11 = $("#pQ11").text();
    var strAns11 = $('input[name="speak"]:checked').val();
    ResultArray.push({ Question: strQuestion11, GivenAns: strAns11, Category: category3 });

    //Question 12
    var strQuestion12 = $("#pQ12").text();
    var strAns12 = $('input[name="anonymous"]:checked').val();
    ResultArray.push({ Question: strQuestion12, GivenAns: strAns12, Category: category3 });

    //Question 13
    var strQuestion13 = $("#pQ13").text();
    var strAns13 = $('input[name="retaliation"]:checked').val();
    ResultArray.push({ Question: strQuestion13, GivenAns: strAns13, Category: category3 });

    //Question 14
    var strQuestion14 = $("#pQ14").text();
    var strAns14 = $('input[name="independent"]:checked').val();
    ResultArray.push({ Question: strQuestion14, GivenAns: strAns14, Category: category3 });

    //Question 15
    var strQuestion15 = $("#pQ15").text();
    var strAns15 = $('input[name="encourage"]:checked').val();
    ResultArray.push({ Question: strQuestion15, GivenAns: strAns15, Category: category3 });

    //get user details

    var stxtName = $('#txtName').val();
    var stxtEmail = $('#txtEmail').val();
    var stxtOrganisation = $('#txtOrganisation').val();
    var stxtRole = $('#txtRole').val();
    var stxtPhone = $('#txtPhone').val();

    var dataNewExaminor = {
        "Name": stxtName,
        "EmailAddress": stxtEmail,
        "Organisation": stxtOrganisation,
        "Role": stxtRole,
        "Phone": stxtPhone
    };

    //var reqData = generatePdfStream();
    var reqData = generate();

    var strFinalData = JSON.stringify({
        userDetails: dataNewExaminor,
        assesmentColn: ResultArray,
        pdfContent: reqData
    });

    $.ajax({
        url: '/api/AssessmentResults',
        method: 'POST',
        data: strFinalData,
        async: true,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        beforeSend: function () {
            $("#overlay").show();
        },
        success: function (response) {
            if (response != null && response != "") {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
                $("#divSuccess").show();
                $("#divTopHead").hide();
                $("#divUserDetails").hide();
                $("#divQuestionaire").hide();
                $("#divAssesmentDetails").hide();
            }
            $("#overlay").hide();
        },
        error: function (response) {
            $("#overlay").hide();
            alert(response.responseText);
        },
        failure: function (response) {
            $("#overlay").hide();
            alert(response.responseText);
        }
    });

}

function generatePdfStream() {
    var doc = new jsPDF();  //create jsPDF object

    var divContents = $("#divAssesmentDetails").html();
    var divTopContents = $("#divQuestionaire").html();

    let footer = new Image();
    footer.src = "/assets/images/logo-wbuk.png";
    doc.addImage(footer, 10, 5, 180, 40);
    doc.line(15, 50, 180, 50);


    doc.fromHTML(divTopContents + divContents, 15, 60);

    var binary = doc.output();
    return binary ? btoa(binary) : "";

}
function headerFooterFormatting(doc) {
    var totalPages = doc.internal.getNumberOfPages();

    for (var i = totalPages; i >= 1; i--) { //make this page, the current page we are currently working on.
        doc.setPage(i);

        header(doc);

        // footer(doc, i, totalPages);

    }
};
function header(doc) {

    let headerImg = new Image();
    headerImg.src = "/assets/images/logo-wbuk.png";

    doc.addImage(headerImg, 10, 5, 180, 40);
}
function testPDF() {

    var base64Img = null;
    margins = {
        top: 70,
        bottom: 40,
        left: 30,
        width: 550
    };


    var pdf = new jsPDF('p', 'pt', 'a4');
    pdf.setFontSize(18);
    pdf.fromHTML($("#html-2-pdfwrapper").html(),
        margins.left, // x coord
        margins.top,
        {
            // y coord
            width: margins.width// max width of content on PDF
        }, function (dispose) {
            headerFooterFormatting(pdf)
        },
        margins);

    var iframe = document.createElement('iframe');
    iframe.setAttribute('style', 'position:absolute;right:0; top:0; bottom:0; height:100%; width:650px; padding:20px;');
    document.body.appendChild(iframe);

    iframe.src = pdf.output('datauristring');


    return;


    var doc = new jsPDF();  //create jsPDF object
    var divContents = $("#html-2-pdfwrapper").html();


    //let footer = new Image();
    //footer.src = "/assets/images/logo-wbuk.png";

    //doc.addImage(footer, 10, 5, 180, 40);
    //doc.line(15, 50, 180, 50);
    doc.fromHTML(divContents, // page element which you want to print as PDF
        15,
        5,
        {
            'width': 170  //set width
        },
        function (a) {

            var dd = doc.output('arraybuffer');
            doc.save("CaseHistroy.pdf"); // save file name as HTML2PDF.pdf

        });


    //var doc = new jsPDF();  //create jsPDF object
    //var divContents = $("#divAssesmentDetails").html();
    //var divTopContents = $("#divQuestionaire").html();


    //let footer = new Image();
    //footer.src = "/assets/images/logo-wbuk.png";

    //doc.addImage(footer, 10, 5, 180, 40);
    //doc.line(15, 50, 180, 50);
    //doc.fromHTML(divTopContents + divContents, // page element which you want to print as PDF
    //    15,
    //    60,
    //    {
    //        'width': 170  //set width
    //    },
    //    function (a) {

    //        doc.save("CaseHistroy.pdf"); // save file name as HTML2PDF.pdf

    //    });
}

function generatePDFFile() {

    var reqData = generatePdfStream();

    var strFinalData = JSON.stringify({
        pdfContent: reqData
    });

    $.ajax({
        type: "POST",
        url: '/api/AssessmentResults',
        async: false,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: strFinalData,
        success: function (data, textStatus, xhr) {

            alert("success");
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(textStatus + ': ' + errorThrown);
        }
    });

}

function AddNewAssesment() {

    //showSuccessMessage("Your assesment has been submitted.");
    constructAssesmentResult();

}

//generate PDF 

var base64Img = null;
imgToBase64('/assets/images/logo-wbuk.png', function (base64) {
    base64Img = base64;
});

margins = {
    top: 70,
    bottom: 40,
    left: 30,
    width: 550
};

generate = function () {
    var pdf = new jsPDF('p', 'pt', 'a4');
    pdf.setFontSize(18);
    pdf.fromHTML(document.getElementById('html-2-pdfwrapper'),
        margins.left, // x coord
        margins.top,
        {
            // y coord
            width: margins.width// max width of content on PDF
        }, function (dispose) {
            headerFooterFormatting(pdf, pdf.internal.getNumberOfPages());
        },
        margins);

    //var iframe = document.createElement('iframe');
    //iframe.setAttribute('style','position:absolute;right:0; top:0; bottom:0; height:100%; width:650px; padding:20px;');
    //document.body.appendChild(iframe);

    //iframe.src = pdf.output('datauristring');
    var retunArray = pdf.output();
    //alert(retunArray);
    //pdf.save("HTMLtoPDF.pdf");
    return retunArray ? btoa(retunArray) : "";

};

function headerFooterFormatting(doc, totalPages) {
    for (var i = totalPages; i >= 1; i--) {
        doc.setPage(i);
        //header
        header(doc);

        footer(doc, i, totalPages);
        doc.page++;
    }
};

function header(doc) {
    doc.setFontSize(30);
    doc.setTextColor(40);
    doc.setFontStyle('normal');

    if (base64Img) {
        doc.addImage(base64Img, 'JPEG', 200, 10, 250, 80);
    }

    //doc.text("Report Header Template", margins.left + 50, 40);

    doc.setLineCap(2);
    doc.line(10, 100, margins.width + 43, 100); // horizontal line
};

function imgToBase64(url, callback, imgVariable) {

    if (!window.FileReader) {
        callback(null);
        return;
    }
    var xhr = new XMLHttpRequest();
    xhr.responseType = 'blob';
    xhr.onload = function () {
        var reader = new FileReader();
        reader.onloadend = function () {
            imgVariable = reader.result.replace('text/xml', 'image/jpeg');
            callback(imgVariable);
        };
        reader.readAsDataURL(xhr.response);
    };
    xhr.open('GET', url);
    xhr.send();
};

function footer(doc, pageNumber, totalPages) {

    var str = "Page " + pageNumber + " of " + totalPages

    doc.setFontSize(10);
    doc.text(str, margins.left, doc.internal.pageSize.height - 20);

};