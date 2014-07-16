
$(function() {
  $('.activities').on('click', function(){
    $('.activity-box').show();
    $('.event-box').hide();
    $('.invite-box').hide();
  });
})

$(function() {
  $('.events').on('click', function(){
    $('.activity-box').hide();
    $('.event-box').show();
    $('.invite-box').hide();
  });
})

$(function() {
  $('.invites').on('click', function(){
    $('.activity-box').hide();
    $('.event-box').hide();
    $('.invite-box').show();
  });
})

$(".alert").alert()

$('ul.nav-pills li a').on('click', function () {
  $('ul.nav-pills li.active').removeClass('active')
  $(this).parent('li').addClass('active')
})

$(function () {
  $('#datetimepicker1').datetimepicker()
});
