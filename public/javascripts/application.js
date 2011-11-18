// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    
      // checks to see if sort column is specified in table
      var sort_col = $("table.sorted").attr('data-sort-column');
      sort_col = sort_col == undefined ? 1 : parseInt(sort_col);

      $("table.sorted").tablesorter( { sortList: [[ sort_col, 0 ]] } )
    
 

//    $("#back-to-search").click(function(){ history.go(-1); return false; });
        




  
  
});

