$(document).ready(function(){
  var cost = document.getElementById('cost').getAttribute('value');
  $('#order_rental_period').change(function() {
    var costs = $('#order_rental_period').val() * cost;
    $('#cost').html(costs);
    $('#order_cost').val(costs);
  });
})
