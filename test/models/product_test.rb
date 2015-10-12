# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  describe                    :text(65535)
#  cover_path                  :string(255)
#  title                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  user_id                     :integer
#  user_collect_products_count :integer          default(0)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
