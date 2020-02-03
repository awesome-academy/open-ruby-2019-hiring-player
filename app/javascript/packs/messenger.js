$( document ).ready(function() {
  $('.chat_list').on('click', function(){
    $('.mesgs').addClass('active_chat');
    $('.user_chat > .chat_list').removeClass('active_chat');

    var $this = $(this);
    if (!$this.hasClass('active_chat')) {
      $this.addClass('active_chat');
    }
  });
});
