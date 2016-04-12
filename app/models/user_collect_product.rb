# == Schema Information
#
# Table name: user_collect_products
#
#  id         :integer          not null, primary key
#  product_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserCollectProduct < ActiveRecord::Base

  belongs_to :user
  belongs_to :product, counter_cache: true
  
end
