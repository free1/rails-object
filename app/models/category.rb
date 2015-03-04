class Category < ActiveRecord::Base

	has_many :product_category_ships, dependent: :destroy
	has_many :products, through: :product_category_ships

	validates :name, presence: true

	scope :created_time, -> { order(id: :desc) }

end
