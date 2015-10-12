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
#

class FoodElement < ActiveRecord::Base
end
