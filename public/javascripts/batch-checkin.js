$(document).ready(function(){
    console.log('loaded');
  var titleData = [];
  $.get('/books/title_data', function(data){ 
      titleData = $.makeArray(data);

    $(".autocomplete_book_title").autocomplete({
        source: function(req, responseFn){
          var re = $.ui.autocomplete.escapeRegex(req.term);
          var a = $.grep(titleData, function(item, index){
            var matcher = new RegExp("(?:^| )" + re, "gi");
            return matcher.test(item);
          });
          responseFn(a); 
        },
        minLength: 1
     });


  });

  $(":checkbox").click(function(){
      var checkout_id = $(this).attr('id').split("_")[2];
      $("#checkout_item_" + checkout_id + "_next").focus();
      });
        
});


