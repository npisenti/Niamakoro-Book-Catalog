$(document).ready(function(){

    // Tests to see if graph container exists
    // If not, then no checkouts -> no need to
    // get stats.
    
    if ($("#graph-container").length) {
      var plotData = [];
      $.get('#', function(data){
        plotData = $.makeArray(data);
        $.plot($("#graph-container"), [plotData], { xaxis: { max: 1, tickDecimals: 0 }, yaxis: { min: 0, tickDecimals: 0 }, series: { bars: { show: true, align: "center"}}});
      }, 'json'); 
    };

    });
