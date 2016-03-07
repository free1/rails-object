# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  number       :string(255)
#  state        :string(255)
#  trans_amount :decimal(8, 2)    default(0.0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Order < ActiveRecord::Base
    include AASM

    before_validation :generate_number, on: :create

    enum state: {
      init: 10,
      confirmed: 11,
      deposited: 12,
      paid: 13,
      fulfilled: 14,
      succeed: 90,
      closed: 91,
      commented: 92,
      refunding: 20
    }
    STATUS_NAME = {
      init: '下单',
      confirmed: '接单',
      deposited: '已付定金',
      paid: '已付款',
      fulfilled: '商家已服务',
      succeed: '用户确认服务',
      closed: '关闭',
      commented: '已评论',
      refunding: '退款中'
    }

    aasm column: :state, whiny_transitions: false, enum: true do
      state :init, :initial => true
      state :confirmed
      state :deposited
      state :paid
      state :fulfilled
      state :succeed
      state :commented
      state :closed
      state :refunding

      # 提交订单
      event :confirm do
        transitions from: :init, to: :confirmed
        before do
        end
        after do
        end
      end

      # 付定金
      event :deposit do
        transitions from: :confirmed, to: :deposited, guard: [:can_deposit?]
      end

      # 付余款
      event :pay_remaining do
        transitions from: :deposited, to: :paid
      end

      # 用户确认服务完成
      event :service_confirm do
        transitions from: :paid, to: :succeed
      end

      # 确认服务之后新增评论
      event :post_comment do
        transitions from: :succeed, to: :commented
      end

      # 取消订单
      event :cancel do
        transitions from: [:init, :confirmed], to: :closed
      end

      # 申请退款
      event :refund do
        transitions from: [:deposited, :paid], to: :refunding
      end

      # 后台完成退款，关闭交易
      event :close do
        transitions from: [:refunding], to: :closed
      end

    end # end aasm

    private

      def generate_number
         self.number = Time.zone.now.strftime("%Y%m%d") + id.to_s + SecureRandom.hex(3).upcase
      end
   
end
