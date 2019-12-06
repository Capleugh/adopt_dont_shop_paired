require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate total number of faves it holds" do
      cart = Cart.new({'1' => 1})

      expect(cart.total_count).to eq(1)
    end

    describe "#count_of" do
      it "returns the count of pets in favorites" do
        cart = Cart.new({})

        expect(cart.count_of(1)).to eq(0)
      end
    end
  end
end
