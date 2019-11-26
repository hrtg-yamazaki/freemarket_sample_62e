require 'rails_helper'

RSpec.describe Item, type: :model do 

  describe "#create" do

    context '保存できる' do
      it "全てのカラムが埋まっていれば、保存できる" do
        item = create(:item)
        expect(item).to be_valid
      end
      # it "" do
      # end
      # it "" do
      # end
      # it "" do
      # end

    end

    context '保存できない' do

    end

  end
end