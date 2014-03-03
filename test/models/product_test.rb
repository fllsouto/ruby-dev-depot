require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
  test "product attributes must not be empty" do 
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "my book title",
						  description: "yyy",
						  image_url: "zzz.jpg")
		product.price = -1
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",
			product.errors[:price].join(';')

		product.price = 0
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",
			product.errors[:price].join(';')

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(title: "My Book Title",
								description: "yyy",
								price: 1,
								image_url: image_url)
	end

	test "image URL ends with one of .gif, .png or .jpg" do
		correct_array = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    incorrect_array = %w{ fred.doc fred.gif/more fred.gif.more } 
	
		correct_array.each do | item | 
			assert new_product(item).valid? , "#{item} shouldn't be invalid"
		end
		incorrect_array.each do | item | 
			assert new_product(item).invalid? , "#{item} shouldn't be valid"
		end
	end

	test "product is not valid without a unique title" do
		product = Product.new(title: products(:ruby).title,
													description: "yyy",
													price: 1,
													image_url: "fred.gif"
			)
		assert !product.save
		assert_equal "has already been taken", product.errors[:title].join('; ')
	end

	test "product title is too short" do
		product = Product.new(description: "yyy",
													price: 1,
													image_url: "fred.gif"
			)
		product.title = "waka"
		assert product.invalid?
		assert_equal "is too short (The minimum is 5 characters)",
			product.errors[:title].join(';')
	end

	test "product title is too long" do
		product = Product.new(description: "yyy",
													price: 1,
													image_url: "fred.gif"
			)
		product.title = "thistitleisveryverylargeandthisisnotgood"
		assert product.invalid?
		assert_equal "is too long (The maximum is 25 characters)",
			product.errors[:title].join(';')
	end
end
