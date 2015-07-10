# == Schema Information
#
# Table name: user_collects
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  listable_id   :integer
#  listable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  kind          :integer
#

class UserCollect < ActiveRecord::Base

	belongs_to :user
	belongs_to :listable, polymorphic: true
	# 类型
	enum kind: {favorite: 0, zan: 1}

	validates_uniqueness_of :user_id, scope: [:listable_id, :listable_type, :kind]
	validates :kind, presence: true, inclusion: { :in => %w(favorite zan) }

	scope :favorites, -> { where(kind: 0) }
	scope :zans, -> { where(kind: 1) }
end
