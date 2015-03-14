$(document).on("ready", function() {
    var id = $('h2').attr("id");
        var url = '/chart'
        request = $.ajax({
            url: url,
            type: 'POST',
            data: {id: id},
            dataType: 'JSON',
        }).done(renderChart);
});

function renderChart(response){
    var frequencies = response.frequencies;
    var answerData = [];
    for (answer in frequencies){
        answerData.push({
            x: answer,
            y: frequencies[answer],
        });
    }

    var result_chart = new CanvasJS.Chart("chartContainer", {
        title: {
            text: response.question
        },
        type: "column",
        axisX: {
            title: "Answer",
            minimum: response.min,
            maximum: response.max
        },
        axisY: {
            title: "Votes"
        },
        data: [{
            dataPoints : answerData
        }]
    });
    result_chart.render();
}

