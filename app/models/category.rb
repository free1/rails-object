class Category < ActiveRecord::Base

	has_many :product_category_ships, dependent: :destroy
	has_many :products, through: :product_category_ships

end
