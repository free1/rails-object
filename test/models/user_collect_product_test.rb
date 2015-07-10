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

require 'test_helper'

class UserCollectProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
