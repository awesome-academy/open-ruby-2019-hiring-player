$(document).ready(function(){
  $('.star-rating').click(function() {
    $('#rated').rating('refresh', {disabled:true, showClear:false});
    var user_id = $('#rated').attr('data-user-id');
    var vote = $('#rated').attr('value');
      
    $.ajax({
      type: 'post',
      url: '/users/' + user_id + '/rate',
      data: {rating: vote}
    });
  });
});
