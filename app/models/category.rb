# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :integer          default(0)
#

class Category < ActiveRecord::Base

  has_many :product_category_ships, dependent: :destroy
  has_many :products, through: :product_category_ships

  validates :name, presence: true

  scope :created_time, -> { order(id: :desc) }

end
