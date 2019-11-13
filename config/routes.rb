Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'items#index'
  resources :items, only: :index

  
  #ユーザー登録関連(addresses要修正、多分ネストする)
  resources :users, only: :create

  resources :addresses, only: :create

  scope "signup" do
    root                         "signup#signup",           as: "signup"
    get   "registration",    to: "signup#registration",     as: "signup_registration"
    scope "sms_confirmation" do
      root                       "signup#confirmation",     as: "signup_confirm"
      get "sms",             to: "signup#confirmation_sms", as: "signup_confirm_sms"
    end
    get   "deliver_address", to: "signup#address",          as: "signup_address"
    get   "card",            to: "signup#card",             as: "signup_card"
    get   "complete",        to: "signup#complete",         as: "signup_complete"
  end
  #ここまで
  

  #マイページ関連
  scope "mypage" do
    root "users#mypage", as: "mypage"
  end
  #ここまで


end


