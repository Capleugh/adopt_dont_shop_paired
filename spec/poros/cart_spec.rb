require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate total number of faves it holds" do
      cart = Cart.new({'1' => 1})

      expect(cart.total_count).to eq(1)
    end
  end

  describe "#remove_favorite" do
    it "removes a favorite to its contents" do
        cart = Cart.new({'1' => 1,
                         '2' => 1 })

      cart.remove_favorite(1)

      expect(cart.contents).to eq({'2' => 1 })
    end
  end

  describe "#all_favorites" do
    it "can find all pets in favorites" do
      cart = Cart.new({'1' => 1,
                       '2' => 1 })

      expect(cart.all_favorites).to eq([1, 1])
    end
  end
end
