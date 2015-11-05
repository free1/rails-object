module Tool

  class SendSms
    ChinaSMS.use :yunpian, password: ''

    class << self

      # Tool::SendSms.send_sms(phone, template)
      def send_sms(to_phone_num, template)
        ChinaSMS.to to_phone_num, template
      end

    end
  end

end
