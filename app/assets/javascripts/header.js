$(function(){

  const category = $('.header-bottom__left__category');
  const category_list = $('.category_list');

  const brand = $('.header-bottom__left__brand');
  const brand_list = $('.brand_list');

  const notice = $('.header-bottom__right__content--notice');
  const notice_list = $('.info-list--notice');

  const todo = $('.header-bottom__right__content--todo');
  const todo_list = $('.info-list--todo');

  const mypage = $('.header-bottom__right__content--mypage');
  const mypage_list = $('.info-list--mypage');


  category.hover(
    function(){
      category_list.show();
    },
    function(){
      category_list.hide();
    }
  );

  brand.hover(
    function(){
      brand_list.show();
    },
    function(){
      brand_list.hide();
    }
  );

  notice.hover(
    function(){
      notice_list.show();
    },
    function(){
      notice_list.hide();
    }
  );

  todo.hover(
    function(){
      todo_list.show();
    },
    function(){
      todo_list.hide();
    }
  );

  mypage.hover(
    function(){
      mypage_list.show();
    },
    function(){
      mypage_list.hide();
    }
  );





});