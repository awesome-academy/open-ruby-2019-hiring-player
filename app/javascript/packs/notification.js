$( document ).ready(function() {
  $(document).on('click', '.notification', function(){
    var notification_id = $('#notification_id').val();
    var path = $('#path').val();
    $.ajax({
      type: 'PUT',
      url: '/sender_recipients/' + notification_id,
      data: {notification: notification_id, path: path}
    });
  });
});
