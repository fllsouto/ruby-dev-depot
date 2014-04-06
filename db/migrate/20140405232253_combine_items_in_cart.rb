class CombineItemsInCart < ActiveRecord::Migration
  def change
  end
  	#replace multiple items for a single product in a cart with a single item
  def up
  	Cart.all.each do |cart|
  		#count the number of each product in the cart
  		sums = cart.line_items.group(:product_id).sum(:quantity)
  		#TODO: Search later about group() and sum() methods
  		#sums will be a two indexed vector 
  		sums.each do |product_id, quantity|
  			if quantity > 1
  				#remove individual items
  				cart.line_items.where(product_id: product_id).delete_all

  				#replace with single item
  				cart.line_items.create(product_id: product_id, quantity: quantity)
  			end
  		end
  	end
  end

  def down
  	#split items with quantity > 1 into multiple items
  	LineItem.where("quantity>1").each do |line_item|
  		#add individual items
  		line_item.quantity.times do
  			LineItem.create cart_id: line_item.cart_id,
  				product_id: line_item.product_id, quantity: 1
  		end

  		#remove original item
  		line_item.destroy
  	end
  end
end
