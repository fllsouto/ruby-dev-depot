class LineItem < ActiveRecord::Base
	#This specifies an  ownership link between line item and the other entities.
	belongs_to :product
	belongs_to :cart
end
