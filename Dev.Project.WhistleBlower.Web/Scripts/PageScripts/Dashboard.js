$(document).ready(function () {
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
                var dps1Pie = [];

                for (var i = 0; i < response.length; i++) {
                    dps1Bar.push({ y: response[i].IncidentTotal, label: response[i].MonthName });
                    dps1Pie.push({ y: response[i].IncidentTotal, indexLabel: response[i].MonthName });
                }


                generateBarDashboard(dps1Bar);
                generatePieDashboard(dps1Pie);
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

function generateBarDashboard(dps1) {

    var chart = new CanvasJS.Chart("barchartContainer", {
        animationEnabled: true,

        title: {
            text: "Incidents per month"
        },
        axisY2: {
            interlacedColor: "rgba(1,77,101,.2)",
            gridColor: "rgba(1,77,101,.1)",
            title: "Number of Incidents"
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
function generatePieDashboard(dps1) {
    var chart = new CanvasJS.Chart("piechartContainer",
	{
	    title: {
	        text: "Incidents per month"
	    },
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