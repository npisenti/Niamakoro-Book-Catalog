// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    $("#search").focus();

    /// Get the source for this plugin!
//    $("#tableSortTest").tablesorter( { sortList: [[ 1, 0 ]] } )

    var autoData = [];
    var subjectData = [];

    $.get('/search_bar', function(data){ 
        autoData = $.makeArray(data);
        console.log(autoData);
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

    $.get('/subjects.json', function(data){
        subjectData = $.makeArray(data);
        console.log(subjectData);
        });
    
    $("#search-button").click(function(){
        window.location = "/?search=" + $("#search").attr("value");
    });

//    $("#back-to-search").click(function(){ history.go(-1); return false; });
        


// FOR BOOK FORM
$("#subjects_0_name").autocomplete({
          source: function(req, responseFn){
            var re = $.ui.autocomplete.escapeRegex(req.term);
            var a = $.grep(subjectData, function(item, index){
              var matcher = new RegExp("(?:^| )" + re, "ig");
              return matcher.test(item);
            });
            responseFn(a); 
          },
          minLength: 1,
          select: function( event, ui ) {
      }
    }); 


  $('#new-subject').click(function(){
    var i = parseInt($('#subject-inputs').attr('data-counter')) + 1;
    var new_node = '<div class="clearfix"><label for="subjects_' + i + '_name">Subject</label><div class="input"><input class="xlarge subject" id="subjects_' + i + '_name" name="subjects[' + i + '][name]" size="30" type="text" value=""><a href="#" class="close" id="close-subject-' + i + '">×</a></div></div>'

    $(new_node).appendTo('#subject-inputs');
    $("#subjects_" + i + "_name").autocomplete({
          source: function(req, responseFn){
            var re = $.ui.autocomplete.escapeRegex(req.term);
            var a = $.grep(subjectData, function(item, index){
              var matcher = new RegExp("^" + re, "i");
              return matcher.test(item);
            });
            responseFn(a); 
          },
          minLength: 1,
          select: function( event, ui ) {
      }
    }); 

      $('#close-subject-' + i).click(function(){ $(this).parentsUntil($('#subject-inputs'), '.clearfix').remove();
       return false;
       });

      $('#subject-inputs').attr('data-counter', i);
      return false;
    });

  $('#new-author').click(function(){
    var i = parseInt($('#author-inputs').attr('data-counter')) + 1;
    var new_node = '<div class="row" id="author-number-' + i + '"><div class="span10 offset1"><div class="clearfix"><label for="authors_' + i + '_last">Author Last</label><div class="input"><input class="xlarge" id="authors_' + i + '_last" name="authors[' + i + '][last]" size="30" type="text"><a href="#" class="close" id="close-author-' + i + '">×</a></div></div><div class="clearfix"><label for="authors_' + i + '_first">Author First</label><div class="input"><input class="xlarge" id="authors_' + i + '_first" name="authors[' + i + '][first]" size="30" type="text"></div></div></div></div>'

    $(new_node).appendTo('#author-inputs');
  
      $('#close-author-' + i).click(function(){ $(this).parentsUntil($('#author-inputs'), '.row').remove();
       return false;
       });

      $('#author-inputs').attr('data-counter', i);
      return false;

  });

make_checkout();
  ///////
  
  
});


var make_checkout = function(){

  $("#parent-checkout").modal({
        keyboard: true,
        backdrop: true
        });
  $("#parent-checkout").bind('shown', function(){
      $("#checkout-form #checkout_item_notes").focus();
    });
  
  $("#checkout-form-cancel").click(function(){
      $("#parent-checkout").modal('hide');
      $("#checkout-form #checkout_item_notes").attr('value', '');
      });
  $("#parent-checkin").modal({
        keyboard: true,
        backdrop: true
        });
  $("#checkin-form-cancel").click(function(){
      $("#parent-checkin").modal('hide');
      });



  $("#checkout-item-form").submit(function(){
      $.post($(this).attr('action'), $(this).serialize(), null, "script");
      return false;

      });

  $("#checkin-item-form").submit(function(){
      $.post($(this).attr('action'), $(this).serialize(), null, "script");
      return false;

      });

  $("#close-current-checkouts").click(function(){
      $("#parent-current-checkouts").modal('hide');
      });

  $("#parent-currently-out").modal({ keyboard: true, backdrop: true });
  $("#close-currently-out").click(function(){
      $("#parent-currently-out").modal('hide');
      });




};
