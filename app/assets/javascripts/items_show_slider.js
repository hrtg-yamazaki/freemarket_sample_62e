$(function(){

  const main = $('.main-slider');

  main.slick({
    arrows: false,
    dotsClass: 'picture--sub',
    dots: true,
    customPaging: function(slick,index) {
      var targetImage = slick.$slides.eq(index).find('img').attr('src');
      return '<img class="pic-size", src=" ' + targetImage + ' "/>';
    },
  });

  $( '.picture--sub li' ).hover(function() {
    $( this ).click();
  },
  function(){
  });

});