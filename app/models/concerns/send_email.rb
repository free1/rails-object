require 'rest_client'

module SendEmail
  extend ActiveSupport::Concern

  module ClassMethods
    def send_mail(to_email, subject, html)
      response = RestClient.post SendCloudAddress,
      :api_user => SendCloudApiUser,
      :api_key => SendCloudApiKey,
      :from => SendCloudFormEmail,
      :fromname => SendCloudFormName,
      :to => to_email,
      :subject => subject,
      :html => html
      return response
    end

    # response = send_mail
    # puts response.code
    # puts response.to_str

  end

  # extend ClassMethods
end
