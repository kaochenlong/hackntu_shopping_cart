class OrdersController < ApplicationController
  before_action :init_cart

  def create
    order = Order.new(order_params)
    @cart.items.each do |item|
      order.order_items.build(product: item.product, quantity: item.quantity)
    end

    if order.save
      # 1. 刷卡
      result = Braintree::Transaction.sale(
        :amount => @cart.total_price,
        :payment_method_nonce => params[:payment_method_nonce],
        :options => {
          :submit_for_settlement => true
        }
      )

      if result
        # 2. 清除購物車
        session['my_super_cart'] = nil
        # 3. 完成後轉往首頁
        redirect_to products_path, notice:'感謝您!!'
      else
        # 失敗處理
      end
    else
      # 失敗處理
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end
end
