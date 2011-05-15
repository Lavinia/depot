class StoreController < ApplicationController
  def index
    #list all products.
    @products = Product.all
    @time = Time.now
    @count = increment_count
  end
  
  def increment_count
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
  
end
