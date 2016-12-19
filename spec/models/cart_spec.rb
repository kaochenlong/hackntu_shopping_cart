require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物車基本功能" do

    it "可以新增商品到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1)
      expect(cart).not_to be_empty
      expect(cart.items.count).to be 1
    end

    it "如果加了相同種類的商品，購買項目(CartItem)並不會增加，但數量會改變" do
      cart = Cart.new
      3.times {
        cart.add_item(1)
      }
      5.times {
        cart.add_item(2)
      }
      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      p1 = Product.create(title:'aaa', price:100)

      cart = Cart.new
      cart.add_item(p1.id)
      expect(cart.items.first.product_id).to be p1.id
      expect(cart.items.first.product).to be_a Product
    end

    it "可以計算整個購物車的總消費金額" do
      p1 = Product.create(title:'aaa', price:100)
      p2 = Product.create(title:'aaa', price:50)

      cart = Cart.new
      3.times { cart.add_item(p1.id) }
      5.times { cart.add_item(p2.id) }

      expect(cart.items.first.total_price).to be 300
      expect(cart.items.last.total_price).to be 250
      expect(cart.total_price).to be 550
    end
  end

  describe "購物車進階功能" do
    #* 因為購物車將以 Session 方式儲存，所以：
    #*
    #*

    it "可以將購物車內容轉換成 Hash" do
      cart = Cart.new

      cart.add_item(2)
      cart.add_item(2)
      cart.add_item(2)

      cart.add_item(5)
      cart.add_item(5)
      cart.add_item(5)
      cart.add_item(5)

      expect(cart.serialize).to eq cart_hash
    end

    it "也可以把 Hash 還原成購物車的內容" do
      cart = Cart.build_from_hash(cart_hash)
      expect(cart.items.first.product_id).to be 2
      expect(cart.items.last.quantity).to be 4
    end
  end

  private
  def cart_hash
    {
      "items" => [
        {"product_id" => 2, "quantity" => 3},
        {"product_id" => 5, "quantity" => 4}
      ]
    }
  end
end
