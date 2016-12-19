class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def init_cart
    @cart = Cart.build_from_hash(session['my_super_cart'])
  end
end
