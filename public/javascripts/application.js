// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    $("#search").focus();

    var autoData = [];
    $.get('/search_bar', function(data){ 
        autoData = $.makeArray(data);
        });

        $("#search").autocomplete({
          source: function(req, responseFn){
            var re = $.ui.autocomplete.escapeRegex(req.term);
            var matcher = new RegExp("^" + re, "i");
            var a = $.grep(autoData, function(item, index){
              return matcher.test(item);
            });
            responseFn(a); 
          },
          minLength: 1,
          select: function( event, ui ) {
      }
    }); 
    
    $("#search-button").click(function(){
        window.location = "/?search=" + $("#search").attr("value");
    });

    $("#back-to-search").click(function(){ history.go(-1); return false; });



// FOR BOOK FORM

  $('#new-subject').click(function(){
    var i = parseInt($('#subject-inputs').attr('data-counter')) + 1;
    var new_node = '<div class="clearfix"><label for="subjects_' + i + '_name">Subject</label><div class="input"><input class="xlarge" id="subjects_' + i + '_name" name="subjects[' + i + '][name]" size="30" type="text" value=""><a href="#" class="close" id="close-subject-' + i + '">×</a></div></div>'
      $(new_node).appendTo('#subject-inputs');

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
  ///////
  
  
});

