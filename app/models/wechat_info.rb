# == Schema Information
#
# Table name: wechat_infos
#
#  id          :integer          not null, primary key
#  public_name :string(255)
#  number      :string(255)
#  qr_code     :string(255)
#  keyword     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class WechatInfo < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user
  
end
