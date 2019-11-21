$(document).on('turbolinks:load', function(){
  
  $('.mypage-news-btn').on('click',function(e){
    e.preventDefault();    
    $('.user_notification_todo__content__list').hide();
    $('.mypage-item-list').show();
    $('.news-color').css('background-color','#fff');
    $('.todo-color').css('background-color','#eee');
    $('.top-active').css('border-top','#ea352d 2px solid');
    $('.todo-color').css('border-top','#fff 2px solid');
  });

  $('.mypage-todo-btn').on('click',function(e){
    e.preventDefault();
    $('.mypage-item-list').hide();
    $('.user_notification_todo__content__list').show();
    $('.todo-color').css('background-color','#fff');
    $('.news-color').css('background-color','#eee');
    $('.todo-color').css('border-top','#ea352d 2px solid');
    $('.top-active').css('border-top','#fff 2px solid');
  });

  $('.mypage-trading-now-btn').on('click',function(e){
   e.preventDefault();
  $('.user_tradings__contents__list-old').hide();
  $('.user_tradings__contents__list-now').show();
  $('.now-color').css('background-color','#fff');
  $('.past-color').css('background-color','#eee');
  $('.bottom-active').css('border-top','#ea352d 2px solid');
  $('.past-color').css('border-top','#fff 2px solid');
  });

  $('.mypage-trading-old-btn').on('click',function(e){
  e.preventDefault();
  $('.user_tradings__contents__list-now').hide();
  $('.user_tradings__contents__list-old').show();
  $('.now-color').css('background-color','#eee');
  $('.past-color').css('background-color','#fff');
  $('.bottom-active').css('border-top','#fff 2px solid');
  $('.past-color').css('border-top','#ea352d 2px solid');
  });
});