# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  sender_id       :integer          default(0)
#  receiver_id     :integer
#  notifiable_id   :integer
#  notifiable_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :integer          default(0)
#  content         :text(65535)
#

class Notification < ActiveRecord::Base

  belongs_to :sender_user, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :receiver_user, foreign_key: 'receiver_id', class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  default_scope { where.not(status: 2) }
  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(status: 0) }

  # 状态
  enum status: {unread: 0, readed: 1, deleted: 2}

  def select_content
    case self.content
    when 'comment'
      '评论了你的文章'
    end
  end
end
