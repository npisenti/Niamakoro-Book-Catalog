
$(document).ready(function(){
  
  make_checkout();
  
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
      return false;
      });
  $("#parent-checkin").modal({
        keyboard: true,
        backdrop: true
        });
  $("#checkin-form-cancel").click(function(){
      $("#parent-checkin").modal('hide');
      return false;
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
      return false;
      });

  $("#parent-currently-out").modal({ keyboard: true, backdrop: true });
  $("#close-currently-out").click(function(){
      $("#parent-currently-out").modal('hide');
      return false;
      });

};
