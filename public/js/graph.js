$(function () {
    $('#question-response').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'What is the best pet?'
        },
        tooltip: {
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Dog',   45.0],
                ['Cat',       26.8],
                {
                    name: 'Ferret',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Penguin',    8.5],
                ['Eagle',     6.2],
                ['Mouse',   0.7]
            ]
        }]
    });
});
    
