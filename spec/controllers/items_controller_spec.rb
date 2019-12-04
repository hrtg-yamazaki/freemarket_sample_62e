require 'rails_helper'

describe ItemsController, type: :controller do
  let(:seller) { create(:user) }
  let(:image) { create (:image) }
  let(:item) { create(:item) }

  describe 'GET #index' do
    it "@items が正しく定義できていて、id降順に並んでいる" do  
      items = create_list(:item, 10)
      get :index
      expect(assigns(:items)).to match(items.sort{ |a,b| b.id <=> a.id})
    end

    it "@items の取得には10件以下のlimitがかかっている" do 
      get :index
      expect(assigns(:items).count <= 10 ).to eq true
    end

    it "index テンプレートが呼び出される" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "@item が正しく定義できている" do
      item = create(:item)
      get :show, params: { id: item }
      expect(assigns(:item)).to eq item
    end

    it "@seller_items が正しく定義できていて、id降順に並んでいる" do
      item = create(:item)
      seller_items = create_list(:item, 6, seller_id: item.seller.id)
      get :show, params: {id: item}
      expect(assigns(:seller_items)).to match(seller_items.sort{ |a,b| b.id <=> a.id})
    end

    it "@seller_items の取得には6件以下のlimitがかかっている" do
      item = create(:item)
      get :show, params: {id: item}
      expect(assigns(:seller_items).count <= 6 ).to eq true
    end

    it "show テンプレートが呼び出される" do
      item = create(:item)
      get :show, params: { id: item }
      expect(response).to render_template :show
    end
  end

  describe 'GET #sell' do
    context 'ログイン中' do
      before do
        login seller
      end

      it "@item が正しく定義できている" do
        get :sell
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "@item_image が正しく定義できている" do
        get :sell
        expect(assigns(:item_image)).to be_a_new(Image)
      end

      it "sell テンプレートが呼び出される" do
        get :sell
        expect(response).to render_template :sell
      end
    end
    context 'ログアウト中' do
      it "ログインページにリダイレクトしている" do
        get :sell
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
      before do
        login seller
      end

      it "@item が正しく定義できている" do
        item = create(:item)
        get :edit, params: { id: item }
        expect(assigns(:item)).to eq item
      end

      it "@add_image が正しく定義できている" do
        item = create(:item)
        get :edit, params: { id: item }
        expect(assigns(:add_image)).to be_a_new(Image)
      end

      it "edit テンプレートが呼び出される" do
        item = create(:item)
        get :edit, params: { id: item }
        expect(response).to render_template :edit
      end
    end

    context 'ログアウト中' do
      it "ログインページにリダイレクトしている" do
        item = create(:item)
        get :edit, params: { id: item }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  describe 'POST #create' do
    let(:params){{item:{name: item.name, text: item.text, condition: item.condition, price: item.price,
                  defrayer: item.defrayer,span: item.span, prefecture_id: item.prefecture_id, seller_id: seller.id,
                }, 
                  images:{image_url: [image.image_url], item_id: item.id, created_at: image.created_at, updated_at: image.updated_at,
                  },
                  }}

    context 'ログイン中' do
      before do
        login seller
      end

      context '保存できる' do
        subject { 
          post :create,
          params: params 
        }

        it "Item テーブルにレコードが作成される" do 
          binding.pry
          expect{ subject }.to change(Item, :count).by(1)
        end

        it "Image テーブルにレコードが作成される" do
        end

        it "トップページにリダイレクトしている" do
        end
      end

      xcontext '画像が0で 保存できない' do
        it "Item テーブルにレコードが作成されない" do
        end

        it "Image テーブルにレコードが作成されない" do
        end

        it "出品ページにリダイレクトしている" do
        end
      end

      xcontext '画像が10枚以上で 保存できない' do
        it "Item テーブルにレコードが作成されない" do
        end

        it "Image テーブルにレコードが作成されない" do
        end

        it "出品ページにリダイレクトしている" do
        end
      end

    end

    xcontext 'ログアウト中' do
      it "ログインページにリダイレクトしている" do
      end
    end

  end





  describe 'PATCH #update' do
    context 'ログイン中' do
      before do
        login seller
      end
    end

    context 'ログアウト中' do

    end

  end

  # describe 'GET #buy' do
  #   it '@imege が正しく定義せれている' do
  #     itme = create(:item)
  #     image = item.images.first
  #     get :buy, params: { id: item }
  #     expect(assigns(:image)).to eq image
  #   end
  # end

end



  end
