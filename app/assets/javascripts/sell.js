$(document).on("turbolinks:load", function(){

  $(function(){


    $(".sell-field-half__content__price").on("input", function(){

      var input = $(".sell-field-half__content__price").val();

      var fee = (input / 10).toFixed();

      var profit = input - fee
      

      if (input.length === 0){

        $(".sell-fee__content__unit").css("display", "none");
        $(".sell-fee__content__value").text("-");

        $(".sell-profit__content__unit").css("display", "none");
        $(".sell-profit__content__value").text("-");

      } else {

        $(".sell-fee__content__unit").css("display", "inline");
        $(".sell-fee__content__value").text(fee);
  
        $(".sell-profit__content__unit").css("display", "inline");
        $(".sell-profit__content__value").text(profit);

      }
    });
  });
});

