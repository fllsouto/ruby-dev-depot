class Cart < ActiveRecord::Base

	#The dependent: :destoy creates a relationship between line_items and Cart... If the cart will be 
	#deleted then all line_items associated with this cart needs to be deleted to.
	
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id) #This is a dynamic finder created by Active Record
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum{ | item | item.total_price}
	end
end
