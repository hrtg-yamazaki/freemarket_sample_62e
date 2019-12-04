Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  ## トップページ ##
  root 'items#index'

  ## 商品関連 ##
  resources :items, only: [:index, :show, :create, :edit , :update, :destroy]

  ## ユーザー新規登録関連 ##
  scope "signup" do
    root                             "signup#signup",                 as: "signup"
    get   "registration",        to: "signup#registration",           as: "signup_registration"
    post  "registration",        to: "signup#registration_post",      as: "signup_registration_post"
    scope "sms_confirmation" do
      root                           "signup#confirmation",           as: "signup_confirm"
      post "",                   to: "signup#confirmation_post",      as: "signup_confirm_post"
      get "sms",                 to: "signup#confirmation_sms",       as: "signup_confirm_sms"
    end
    post  "user_create",         to: "signup#user_create",            as: "signup_user_create"
    get   "address",             to: "signup#address",                as: "signup_address"
    post  "address",             to: "signup#address_create",         as: "signup_address_create"
    get   "credit_card",         to: "signup#card",                   as: "signup_card"
    post  "credit_card",         to: "signup#card_create",            as: "signup_card_create"
    get   "complete",            to: "signup#complete",               as: "signup_complete" 
  end

  ## SNS認証、ログイン、ログアウト ##
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
    }
  devise_scope :user do
    get 'login',                 to: 'devise/sessions#new'
  end
  get  "logout",                 to: "users#logout",                  as: "logout"

  ## マイページ関連 ##
  scope "mypage" do
    root                             "users#mypage",                  as: "mypage"
    get     "profile",           to: "users#profile",                 as: "profile"
    patch   "profile",           to: "users#profile_update",          as: "profile_update"
    get     "identification",    to: "users#identification",          as: "identification"
    get     "card",              to: "users#card",                    as: "mypage_card"
    get     "card/create",       to: "users#card_create",             as: "mypage_card_create"
    post    "card",              to: "users#card_update",             as: "mypage_card_update"
    delete  "card",              to: "users#card_delete",             as: "mypage_card_delete"
    get     "listings/listing",  to: "users#listings",                as: "listings"
    get     "items/m:id",        to: "users#sell_item",               as: "onsale_item"
    delete  "items/m:id",        to: "items#destroy",                 as: "items_destroy"
  end

  ## 商品出品 => 購入 ##
  get  "sell",                   to: "items#sell",                    as: "items_sell"
  get  "transaction/buy/m:id/",  to: "items#buy",                     as: "items_buy"
  post "transaction/buy/m:id",   to: "items#buy_post",                as: "items_buy_post"
  get  "buy/complete",           to: "items#complete",                as: "items_complete"

  ## 商品詳細(TOPページ経由) ##
  get "m:id",                    to: "items#show",                    as: "items_detail"

end
