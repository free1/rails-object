# == Schema Information
#
# Table name: chairs
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chair < ActiveRecord::Base
  include Commentable

  belongs_to :user
  # 关注
  has_many :user_collects, as: :listable, dependent: :destroy
  # has_many :collected_user, through: :user_collects, source: :listable, source_type: 'Chair'

  # 验证
  validates_presence_of :user, :content, :title
end
