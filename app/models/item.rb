class Item < ApplicationRecord

  # assositation
    belongs_to :seller, class_name: "User"
    belongs_to :buyer, class_name: "User", optional: true
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images, allow_destroy: true

  # validation
    validates :name           , presence: { message: "商品名 を入力してください" }        , length: { maximum: 40, message: "商品名 は40文字以内で入力してください" }
    validates :text           , presence: { message: "商品の説明 を入力してください" }     , length: { maximum: 1000, message: "商品の説明 は1000文字以内で入力してください" }
    validates :condition      , presence: { message: "商品の状態 を選択してください" }
    validates :defrayer       , presence: { message: "配送料の負担 を選択してください" }
    validates :prefecture_id  , presence: { message: "発送元の地域 を選択してください" }
    validates :span           , presence: { message: "発送までの日数 を選択してください" }
    validates :price          , presence: { message: "価格 を入力してください" }          , numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "価格 は300以上9999999以下の数字で入力してください" }

  # enum
    enum condition: [ :brandNew, :almostNew, :noDamage, :slightlyDamaged, :damaged, :bad ]
    enum defrayer:  [ :included, :excluded ]
    enum span:      [ :maxTwo, :maxThree, :maxSeven ]
    enum status:    [ :onSell, :inNegotiation, :stopSell, :sold ]
  
  # method
    # def errors_about_images
    #   if @item_image.nil?
    #   elsif
    #   else
    #   end
    # end

end
