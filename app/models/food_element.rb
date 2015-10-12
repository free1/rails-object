# == Schema Information
#
# Table name: food_elements
#
#  id                :integer          not null, primary key
#  image_path        :string(255)
#  nutrition_info    :text(65535)
#  nutrition_value   :text(65535)
#  edible_effect     :text(65535)
#  applicable_people :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  name              :string(255)
#

class FoodElement < ActiveRecord::Base
  serialize :nutrition_info, Hash
  validates :image_path, presence: true
end
