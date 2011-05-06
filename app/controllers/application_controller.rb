class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
    def current_cart    #only available to controllers
      Cart.find(session[:cart_id])  #gets the cart-id from the session object and tries to find a corresponding card.
    rescue ActiveRecord::RecordNotFound #if not found
      cart = Cart.create    #create new cart.
      session[:cart_id] = cart.id       #save cart.id in session.
      cart            #return new cart.
    end
    
end
