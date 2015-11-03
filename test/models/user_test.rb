# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  remember_token         :string(255)
#  verify_token           :string(255)
#  is_verify_email        :boolean          default(FALSE)
#  avatar_path            :string(255)
#  is_email_push          :boolean          default(TRUE)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  phone                  :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
