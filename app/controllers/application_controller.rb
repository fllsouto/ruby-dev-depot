class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private 
  	#Placing this method here alows only controler to use it and prevents that method to 
  	#became an action controller
  	def current_cart 
  		Cart.find(session[:cart_id]) #search in database, session works like a hash table
  	rescue ActionRecord::RecordNotFound #This rescue is for when the cart isn't found
  		cart = Cart.create
  		session[:cart_id] = cart_id
  		cart
  	end
end
