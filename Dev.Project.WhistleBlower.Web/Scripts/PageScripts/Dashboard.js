$(document).ready(function () {

    if (localStorage.getItem("AcctType") != "Admin") {
        window.location.href = "/Pages/ViewIncidents.aspx";
    }
    else
        loadDashboard();
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
                    dps1BarReportable.push({ y: response.incReportable[i].IncidentTotal, label: response.incReportable[i].MonthName + "- " + response.incRegistered[i].Year});
                }
                for (var i = 0; i < response.inchaveWitness.length; i++) {
                    dps1BarWitness.push({ y: response.inchaveWitness[i].IncidentTotal, label: response.inchaveWitness[i].MonthName + "- " + response.incRegistered[i].Year});
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