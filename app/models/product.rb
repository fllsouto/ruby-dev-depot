class Product < ActiveRecord::Base

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true
	validates_length_of :title, 
						within: 5..25, 
						too_short: "is too short (The minimum is 5 characters)", 
						too_long: "is too long (The maximum is 25 characters)"
	validates :image_url, allow_blank: true, format: {
		with: 	%r{\.(gif|jpg|png)\z}i,
		message: 'must be a  URL for GIF, JPG, or PNG image.'
	}

end
