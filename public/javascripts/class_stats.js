$(document).ready(function(){

    // Tests to see if graph container exists
    
    if ($("#graph-container").length) {
      var grade_id = $("#graph-container").attr('data-grade-id');
      var plotData = [];
      $.get('/grades/' + grade_id + '/statistics', function(data){
        plotData = $.makeArray(data);
        $.plot($("#graph-container"), [plotData], { xaxis: { tickDecimals: 0 }, yaxis: { min: 0, tickDecimals: 0 }});
      }, 'json'); 
    };

    });
