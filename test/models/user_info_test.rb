# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  gender     :string(255)      default("secrecy")
#  resume     :text(65535)
#  website    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  longitude  :float(24)        default(0.0)
#  latitude   :float(24)        default(0.0)
#

require 'test_helper'

class UserInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
