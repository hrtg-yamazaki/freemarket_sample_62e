crumb :root do
  link "Fmarket", root_path
end

crumb :mypage do
  link "マイページ", mypage_path
end

crumb :profile do
  link "プロフィール", profile_path
  parent :mypage
end

crumb :identification do
  link "本人情報の登録", identification_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_path
  parent :mypage
end

crumb :listings do
  link "出品した商品-出品中", listings_path
  parent :mypage
end

crumb :card do
  link "支払い方法", mypage_card_path
  parent :mypage
end

crumb :sell_item do
  link "出品商品画面", onsale_item_path
  parent :listings
end 

crumb :show do
  link "商品詳細", item_path
end
