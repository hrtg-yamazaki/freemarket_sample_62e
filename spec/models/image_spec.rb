require 'rails_helper'

RSpec.describe Image, type: :model do 

  describe '#create' do

    context '保存できる' do
      it "全てのカラムが埋まっていたら保存できる" do
        image = build(:image)
        expect(image).to be_valid
      end
    end

  end
end
