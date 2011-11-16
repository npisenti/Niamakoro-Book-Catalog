$(document).ready(function(){

    var plotData = [];
    $.get('#', function(data){
      plotData = $.makeArray(data);
      console.log(plotData);
      $.plot($("#graph-container"), [plotData], { xaxis: { min: 0 }, yaxis: { min: 0 }});
      }, 'json'); 

    });
