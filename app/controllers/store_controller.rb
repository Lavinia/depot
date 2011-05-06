class StoreController < ApplicationController
  def index
    #list all products.
    @products = Product.all
    @time = Time.now
  end
end
