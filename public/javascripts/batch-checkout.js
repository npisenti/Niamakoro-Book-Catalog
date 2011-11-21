$(document).ready(function(){
  var titleData = [];
  $.get('/books/title_data', function(data){ 
      titleData = $.makeArray(data);

      add_bindings(1, titleData);
      });

  $("#book_title_1").focus();

  $("#submit-batch-checkout").click(function(){
    $("#batch-checkout-form").submit();
    });

    
});

var add_bindings = function(index, titleData){

      $("#checkout_notes_" + index).keydown(function(e){
          var nextIndex = parseInt($(this).attr('data-index')) + 1;
          if (e.keyCode == 13){
            add_new_checkout(nextIndex); 
            add_bindings(nextIndex, titleData);
            return false;
           }
          });
  
  
      $("#book_title_" + index).autocomplete({
        source: function(req, responseFn){
          var re = $.ui.autocomplete.escapeRegex(req.term);
          var a = $.grep(titleData, function(item, index){
            var matcher = new RegExp("(?:^| )" + re, "gi");
            return matcher.test(item);
          });
          responseFn(a); 
        },
        minLength: 1,
        select: function( event, ui ) {
        var index = $(this).attr("data-index");
        $("#checkout_notes_" + index).focus();
    }
  });
    

};



var add_new_checkout = function(index){

  var html = "<tr><td><input class='xlarge autocomplete_title' data-index='" + index + "' id='book_title_" + index + "' name='book_title[" + index + "]' size='30' type='text'></td><td><input class='xlarge' id='checkout_notes_" + index + "' name='checkout_notes[" + index + "]' data-index='" + index + "' size='30' type='text'></td></tr>"

    $("#checkout-table-body").append(html);
    $("#book_title_" + index).focus();
 };

