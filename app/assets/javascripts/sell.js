$(document).on("turbolinks:load", function() {

  $(function() {
    
    //***** カテゴリ選択 => 展開機能の仮置き ***** //
    //***** DB連携(Ajax)はカテゴリ機能まで実装できた場合に行う *****/

    // 親要素 => 子 //
    $(".sell-select__category").on("change", function() {
      
      var selectChild = `<div class="sell-select hidden-child">
                          <select class="sell-select__child">
                            <option class="option-prompt">---</option>
                            <option value="1">トップス</option>
                          </select>
                          <i class="fa fa-angle-down"></i>
                        </div>`

      var prompt = "---"
      var selected = $(".sell-select__category").val();
      

      if (selected === "1") {

        $(".js-sell-category").append(selectChild);

      } else if (selected === "5") {
        $(".hidden-child").remove();
        $(".hidden-grandchild").remove();
        $(".hidden-property").remove();

      } else {
        $(".hidden-child").remove();
        $(".hidden-grandchild").remove();

      }
      
      // 子要素 => 孫 //
      $(".sell-select__child").on("change", function() {
        
        var selectGrandchild = `<div class="sell-select hidden-grandchild">
                                  <select class="sell-select__grandchild">
                                    <option class="option-prompt">---</option>
                                    <option value="1">Tシャツ/カットソー(半袖/袖なし)</option>
                                  </select>
                                  <i class="fa fa-angle-down"></i>
                                </div>`
        
        var childPrompt = "---"
        var childSelected = $(".sell-select__child").val();

        if (childSelected === childPrompt) {

          $(".hidden-grandchild").remove();
  
        } else {
  
          $(".js-sell-category").append(selectGrandchild);

        }
        
        // 孫要素 => サイズなどのプロパティ //
        $(".sell-select__grandchild").on("change", function() {

          var selectProperty = `<div class="sell-field-serve hidden-property">
                                  <h3>サイズ</h3>
                                  <span class="required">必須</span>
                                  <div class="sell-select">
                                    <select class="sell-select__property">
                                      <option class="option-prompt">---</option>
                                      <option value="1">XXS以下</option>
                                    </select>
                                    <i class="fa fa-angle-down"></i>
                                  </div>
                                </div>`

          var formBland      = `<div class="sell-field-serve hidden-bland">
                                  <h3>ブランド</h3>
                                  <span class="optional-tag">任意</span>
                                  <div class="sell-form-half">
                                    <input class="sell-form-half__input" placeholder="例）シャネル">
                                  </div>
                                </div>`

          var grandchildPrompt = "---"
          var grandchildSelected = $(".sell-select__grandchild").val();

          if (grandchildSelected !== grandchildPrompt) {

            $(".js-sell-form__detail__box--right").append(selectProperty);
            $(".hidden-bland").remove();
            $(".js-sell-form__detail__box--right").append(formBland);

          }
        })
      })
    })


    // ***** 価格関連表示の自動計算機能 ***** //
    $(".sell-field-half__content__price").on("input", function() {

      var input = $(".sell-field-half__content__price").val();

      var fee = (input / 10).toFixed();

      var profit = input - fee
      

      if (input.length === 0 || input.length > 7 ) {

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

