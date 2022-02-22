$(document).ready(function () {

    if (localStorage.getItem("accessToken") != null && localStorage.getItem("AcctType") == "Admin") {
        loadDashboard();
    }
    else if (localStorage.getItem("accessToken") != null) {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else {
        window.location.href = "/Pages/Login.aspx";
    }


});

function loadDashboard() {

    $.ajax({
        url: '/api/ViewDashboard',
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        },
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        //async: false,
        success: function (response) {
            if (response != "") {
                var dps1Bar = [];
                var dps1BarReportable = [];
                var dps1BarWitness = [];
                var dps1Pie = [];

                //total count
                $('#totalCount').text(response.totalConcerns);

                //Unread count
                $('#unreadCount').text(response.totalConcernsUnread);

                //Important count
                $('#importantCount').text(response.totalConcernsImportant);

                //RTE count
                $('#rteCount').text(response.totalConcernsRTE);

                for (var i = 0; i < response.incRegistered.length; i++) {
                    dps1Bar.push({ y: response.incRegistered[i].IncidentTotal, label: response.incRegistered[i].MonthName + "- " + response.incRegistered[i].Year });
                    dps1Pie.push({ y: response.incRegistered[i].IncidentTotal, indexLabel: response.incRegistered[i].MonthName + "- " + response.incRegistered[i].Year });
                }
                for (var i = 0; i < response.incReportable.length; i++) {
                    dps1BarReportable.push({ y: response.incReportable[i].IncidentTotal, label: response.incReportable[i].MonthName + "- " + response.incRegistered[i].Year });
                }
                for (var i = 0; i < response.inchaveWitness.length; i++) {
                    dps1BarWitness.push({ y: response.inchaveWitness[i].IncidentTotal, label: response.inchaveWitness[i].MonthName + "- " + response.incRegistered[i].Year });
                }


                generateBarDashboard(dps1Bar, "barchartContainer");
                generateBarDashboard(dps1BarReportable, "barchartReportableContainer");
                generatePieDashboard(dps1Pie, "piechartContainer");
                generateBarDashboard(dps1BarWitness, "barchartHaveWitnessContainer");
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

function generateBarDashboard(dps1, chartName) {

    var chart = new CanvasJS.Chart(chartName, {
        animationEnabled: true,


        axisY2: {
            interlacedColor: "rgba(1,77,101,.2)",
            gridColor: "rgba(1,77,101,.1)",
            title: "Number of Concerns"
        },
        data: [{
            type: "bar",
            name: "Incidents",
            indexLabelPlacement: "outside",
            axisYType: "secondary",
            color: "#014D65",
            showInLegend: true,
            dataPoints: dps1
        }]
    });
    chart.render();
}
function generatePieDashboard(dps1, chartName) {
    var chart = new CanvasJS.Chart(chartName,
        {

            legend: {
                maxWidth: 350,
                itemWidth: 120
            },
            data: [
                {
                    type: "pie",
                    showInLegend: true,
                    toolTipContent: "<b>{indexLabel}</b>: {y} Incidents",
                    indexLabelPlacement: "outside",
                    indexLabel: "{y}",
                    legendText: "{indexLabel} (#percent%)",

                    dataPoints: dps1
                }
            ]
        });
    chart.render();
}

function generatePDF() {
    //var doc = new jsPDF();


    //var canvas = $("#barchartContainer .canvasjs-chart-canvas").get(0);
    //var dataURL = canvas.toDataURL();
    //var pdf = new jsPDF();
    //pdf.addImage(dataURL, 'JPEG', 20, 20, 170, 80); //addImage(image, format, x-coordinate, y-coordinate, width, height)
    //pdf.save("IBTWDashboard.pdf");

    //var doc = new jsPDF();
    //var specialElementHandlers = {
    //    '#editor': function (element, renderer) {
    //        return true;
    //    }
    //};

    //doc.fromHTML($('#right-panel').html(), 15, 15, {
    //    'width': 700,
    //    'elementHandlers': specialElementHandlers
    //});
    //doc.save('sample_file.pdf');

    var doc = new jsPDF("p", "mm", "a4");
    var width = doc.internal.pageSize.width;
    var height = doc.internal.pageSize.height;
    var StartX = 10;

    //doc.setFont("arial", "normal");
    //doc.setTextColor(136, 136, 136); // color for fonts
    //doc.setFontSize(16);
    //doc.text(20, 10, 'No of concerns recorded');
    //doc.setDrawColor(136, 136, 136); // color for line
    //doc.line(10, 15, parseInt(width) - 10, 15);
    //var totalConcernsCount = $("#count").text();
    //doc.addImage(totalConcernsCount, 'JPEG', StartX, 20, parseInt(width) - 20, 100);


    //doc.addPage(); // New page

    doc.setFont("arial", "normal");
    doc.setTextColor(136, 136, 136); // color for fonts
    doc.setFontSize(16);
    doc.text(20, 10, 'No of concerns per month');
    doc.setDrawColor(136, 136, 136); // color for line
    doc.line(10, 15, parseInt(width) - 10, 15);
    var canvas1 = $("#barchartContainer .canvasjs-chart-canvas").get(0);
    var dataURL = canvas1.toDataURL();
    doc.addImage(dataURL, 'JPEG', StartX, 20, parseInt(width) - 20, 100);

    doc.setFont("arial", "normal");
    doc.setTextColor(136, 136, 136); // 
    doc.setFontSize(16);
    doc.text(20, 140, 'No of concerns per month');
    doc.setDrawColor(136, 136, 136);
    doc.line(10, 145, parseInt(width) - 10, 145);
    var canvas2 = $("#piechartContainer .canvasjs-chart-canvas").get(0);
    var dataURL2 = canvas2.toDataURL();
    doc.addImage(dataURL2, 'JPEG', StartX, 150, parseInt(width) - 20, 100);

    doc.addPage(); // New page
    doc.setFont("arial", "normal");
    doc.setTextColor(136, 136, 136); // color for fonts
    doc.setFontSize(16);
    doc.text(20, 10, 'No of concerns reportable');
    doc.line(10, 15, parseInt(width) - 10, 15);
    var canvas3 = $("#barchartReportableContainer .canvasjs-chart-canvas").get(0);
    var dataURL3 = canvas3.toDataURL();
    doc.addImage(dataURL3, 'JPEG', StartX, 20, parseInt(width) - 20, 100);
    //doc.addImage(dataURL3, 'JPEG', StartX, 20, parseInt((parseInt(width) - 10) / 2), parseInt((parseInt(width) - 20) / 2));

    doc.setFont("arial", "normal");
    doc.setTextColor(136, 136, 136); // color for fonts
    doc.setFontSize(16);
    doc.text(20, 140, 'No of concerns have witness');
    doc.line(10, 145, parseInt(width) - 10, 145);
    var canvas4 = $("#barchartHaveWitnessContainer .canvasjs-chart-canvas").get(0);
    var dataURL4 = canvas4.toDataURL();
    doc.addImage(dataURL4, 'JPEG', StartX, 150, parseInt(width) - 20, 100);
    //doc.addImage(dataURL4, 'JPEG', StartX, 150, parseInt((parseInt(width) - 10) / 2), parseInt((parseInt(width) - 20) / 2));

    doc.save('IBTWDashboard.pdf'); // Change the name of the pdf file.

}