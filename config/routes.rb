Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'items#index'
  resources :items, only: :index

  devise_for :users
  #ユーザー登録関連
  resources :users, only: :create

  scope "signup" do
    root                         "users#signup",              as: "signup"
    get   "registration",    to: "users#signup_registration", as: "signup_registration"
    scope "sms_confirmation" do
      root                       "users#signup_confirm",      as: "signup_confirm"
      get "sms",             to: "users#signup_confirm_sms",  as: "signup_confirm_sms"
    end
    get   "deliver_address", to: "users#signup_address",      as: "signup_address"
    get   "card",            to: "users#signup_card",         as: "signup_card"
    get   "complete",        to: "users#signup_complete",            as: "signup_complete"
  end
  #ここまで
  

  #マイページ関連
  scope "mypage" do
    root "users#mypage", as: "mypage"
  end
  #ここまで


end
