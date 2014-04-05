class Cart < ActiveRecord::Base

	#The dependent: :destoy creates a relationship between line_items and Cart... If the cart will be 
	#deleted then all line_items associated with this cart needs to be deleted to.
	
	has_many :line_items, dependent: :destroy
end
