# == Schema Information
#
# Table name: phones
#
#  id          :integer          not null, primary key
#  phone_no    :string(255)
#  verify_code :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Phone < ActiveRecord::Base
  # validates_format_of       :phone_no,    :with => /\A1\d{10}\z/
  validates_uniqueness_of   :phone_no

  def self.check_phone_code(phone, code)
    phone = Phone.where(phone_no: phone).first
    if phone.present?
      if phone.verify_code == code
        [true, "success"]
      else
        [false, "无效的验证码"]
      end
    else
      [false, "验证码发送失败"]
    end
  end

  def self.update_verify_code(phone_no)
    phone = Phone.where(phone_no: phone_no).last
    if phone.present? && phone.updated_at + 20.minutes > Time.now
      verify_code = phone.verify_code
    else
      phone = Phone.create(phone_no: phone_no)
      verify_code = [1,2,3,4,5,6,7,8,9,0].sample(6).join  
    end
    [phone, verify_code]
  end

end
