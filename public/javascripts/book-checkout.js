
$(document).ready(function(){
  
  // Makes the modal popups
  $("#parent-checkout").modal({ keyboard: true, backdrop: true });
  $("#parent-checkin").modal({ keyboard: true, backdrop: true });
  $("#parent-current-checkouts").modal({ keyboard: true, backdrop: true });
  
  // Adds focus to text field when modal shown
  $("#parent-checkout").bind('shown', function(){
      $("#checkout-form #checkout_item_notes").focus();
    });
  
  bind_modal_js();
  
});

// binds the various cancel, form submits, etc.
var bind_modal_js = function(){

   
  $("#checkout-form-cancel").click(function(){
      $("#parent-checkout").modal('hide');
      $("#checkout-form #checkout_item_notes").attr('value', ''); // clears form
      return false;
  });
  $("#checkin-form-cancel").click(function(){
      $("#parent-checkin").modal('hide');
      return false;
  });

  $("#close-current-checkouts").click(function(){
      $("#parent-current-checkouts").modal('hide');
      return false;
  });


  // Bindings for form submits
  
  $("#checkout-item-form").submit(function(){
      $.post($(this).attr('action'), $(this).serialize(), null, "script");
      return false;
  });

  $("#checkin-item-form").submit(function(){
      $.post($(this).attr('action'), $(this).serialize(), null, "script");
      return false;
  });

  

};
