# 全大写
SendCloudAddress = YAML.load_file(Rails.root.join('config', 'application.yml'))["address"]
SendCloudApiUser = ENV['api_user']
SendCloudApiKey = ENV["api_key"]
SendCloudFormEmail = ENV["from_email"]
SendCloudFormName = ENV['from_name']
# MailFrom = ENV['domain_from_email']