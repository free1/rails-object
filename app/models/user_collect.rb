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
