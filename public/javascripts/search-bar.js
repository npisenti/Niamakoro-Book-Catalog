$(document).ready(function(){
  
  $("#search").focus();

  // Set up autocomplete 
  var autoData = [];
  $.get('/search_bar', function(data){ 
      autoData = $.makeArray(data);
      });

      $("#search").autocomplete({
        source: function(req, responseFn){
          var re = $.ui.autocomplete.escapeRegex(req.term);
          var a = $.grep(autoData, function(item, index){
            var matcher = new RegExp("(?:^| )" + re, "gi");
            return matcher.test(item);
          });
          responseFn(a); 
        },
        minLength: 2,
        select: function( event, ui ) {
        
    }
  });
  
  /*
  $("#search-button").click(function(){
       window.location = "/?search=" + $("#search").attr("value");
   });
  */
  
  
  
});