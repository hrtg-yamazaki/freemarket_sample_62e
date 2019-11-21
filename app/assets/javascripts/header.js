$(function(){

  var category = $('.header-bottom__left__category');
  var category_list = $('.category_list');

  var brand = $('.header-bottom__left__brand');
  var brand_list = $('.brand_list');


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




});