# == Schema Information
#
# Table name: user_tag_ships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserTagShip < ActiveRecord::Base

  belongs_to :user
  belongs_to :tag

end
