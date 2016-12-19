class CartsController < ApplicationController
  before_action :find_product, only:[:add]
  before_action :init_cart

  def add
    @cart.add_item(@product.id)
    session['my_super_cart'] = @cart.serialize
    redirect_to products_path, notice: '已放至購物車'
  end

  def show
  end

  def checkout
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path if not @product.present?
  end
end
