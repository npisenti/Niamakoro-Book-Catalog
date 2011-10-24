// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    $.getJSON('/search_bar.json', function(data){ 
     $("#search").autocomplete({
source: data, //"search.php",
    minLength: 2,
    select: function( event, ui ) {
    /*    log( ui.item ?
          "Selected: " + ui.item.value + " aka " + ui.item.id :
          "Nothing selected, input was " + this.value );*/
    console.log(event);
    console.log(ui);
    }
    });



     }); 
});

