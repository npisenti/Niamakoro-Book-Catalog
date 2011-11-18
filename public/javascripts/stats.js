$(document).ready(function(){

    // Tests to see if graph container exists
    // If not, then no checkouts -> no need to
    // get stats.
    
    if ($("#graph-container").length) {
      var plotData = [];
      $.get('#', function(data){
        plotData = $.makeArray(data);
        $.plot($("#graph-container"), [plotData], { xaxis: { min: 0 }, yaxis: { min: 0 }});
      }, 'json'); 
    };

    });
