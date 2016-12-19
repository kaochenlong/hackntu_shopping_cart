class OrdersController < ApplicationController
  before_action :init_cart

  def create
    order = Order.new(order_params)
    @cart.items.each do |item|
      order.order_items.build(product: item.product, quantity: item.quantity)
    end

    if order.save
      # 1. 刷卡
      # 2. 清除購物車
      session['my_super_cart'] = nil
      # 3. 完成後轉往首頁
      redirect_to products_path, notice:'感謝您!!'
    else
      #
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end
end
