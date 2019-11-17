Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'items#index'
  resources :items, only: :index

  
  #ユーザー登録関連
  # resources :users, only: :create do
  #   resources :addresses, only: :create
  # end

  devise_for :user
  scope "signup" do
    root                         "signup#signup",                 as: "signup"
    get   "registration",    to: "signup#registration",           as: "signup_registration"
    post  "registration",    to: "signup#registration_post",      as: "signup_registration_post"
    scope "sms_confirmation" do
      root                       "signup#confirmation",           as: "signup_confirm"
      post "",               to: "signup#confirmation_post",      as: "signup_confirm_post"
      get "sms",             to: "signup#confirmation_sms",       as: "signup_confirm_sms"
    end
    post  "user_create",     to: "signup#user_create",            as: "signup_user_create"
    get   "address",         to: "signup#address",                as: "signup_address"
    post  "address",         to: "signup#address_create",         as: "signup_address_create"
    get   "credit_card",     to: "signup#card",                   as: "signup_card"
    get   "complete",        to: "signup#complete",               as: "signup_complete" 
  end
  #ここまで
  

  #マイページ関連
  scope "mypage" do
    root                         "users#mypage",                  as: "mypage"
  end
  #ここまで


end



# resourcesでなければNGだった場合の記述(hamlのprefix指定の修正も必須)

# resources :signup, only: [:new, :create] do
#   collection do
#     get "registration"
#     get "sms_comfirmation"
#     get "sms_comfirmation/sms"
#     get "address"
#     get "credit_card"
#     get "complete"
#   end
# end
