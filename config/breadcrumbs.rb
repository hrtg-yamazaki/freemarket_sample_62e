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

crumb :show do
  link "商品詳細", item_path
end
