
$(document).ready(function(){
  
  $("#parent-books-currently-out").modal({ keyboard: true, backdrop: true });
  
  $("#close-currently-out").click(function(){
      $("#parent-books-currently-out").modal('hide');
      return false;
    });
  
});