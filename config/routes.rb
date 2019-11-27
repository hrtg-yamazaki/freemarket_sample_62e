Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  root 'items#index'
  resources :items, only: [:index, :show, :create]

  
  #ユーザー登録関連

  #SNS関連
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
    }

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
    post  "credit_card",     to: "signup#card_create",            as: "signup_card_create"
    get   "complete",        to: "signup#complete",               as: "signup_complete" 
  end
  #ここまで

  #マイページ関連
  scope "mypage" do

    root                              "users#mypage",                as: "mypage"
    get      "profile",           to: "users#profile",               as: "profile"
    get      "identification",    to: "users#identification",        as: "identification"
    get      "card",              to: "users#card",                  as: "mypage_card"
    get      "card/create",       to: "users#card_create",           as: "mypage_card_create"
    post     "card",              to: "users#card_update",           as: "mypage_card_update"
    delete   "card",              to: "users#card_delete",           as: "mypage_card_delete"
    get      "complete",          to: "users#complete",              as: "mypage_card_complete"

  end
  #ここまで

  get "logout", to: "users#logout", as: "logout"
  get "sell",   to: "items#sell",   as: "items_sell"


end
