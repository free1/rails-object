# send_colud发邮件
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

    # 邮箱验证模版
    def verify_email_template(name, token)
      template = %Q{
        <table cellpadding="0" cellspacing="0" style="font-family: 'lucida Grande', Verdana; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-style: none solid solid; border-right-color: rgb(240, 240, 240); border-bottom-color: rgb(240, 240, 240); border-left-color: rgb(240, 240, 240); color: rgb(88, 88, 88); background-color: rgb(250, 250, 250); font-size: 14px;" width="740">
          <tbody>
            <tr height="40">
              <td style="font-family: 微软雅黑, 黑体, arial; font-size: 18px; -webkit-font-smoothing: subpixel-antialiased; padding-left: 25px; padding-right: 25px;">你好, <span style="font-family: 'microsoft yahei'; font-size: 14px;">#{name}</span>&nbsp;:</td>
            </tr>
            <tr height="15">
              <td style="font-size: 12px; -webkit-font-smoothing: subpixel-antialiased;">&nbsp;</td>
            </tr>
            <tr height="30">
              <td style="font-family: 微软雅黑, 黑体, arial; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 55px;"><span style="color: rgb(88, 88, 88); font-family: 微软雅黑, 黑体, arial; font-size: 14px; line-height: 23px; background-color: rgb(250, 250, 250);">感谢您使用服务。</span></td>
            </tr>
            <tr height="30">
              <td style="font-family: 微软雅黑, 黑体, arial; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 55px;">
              <p>请点击以下链接进行邮箱验证，以便开始使用您的账号：</p>
              </td>
            </tr>
            <tr height="60">
              <td style="font-family: 微软雅黑, 黑体, arial; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 55px;"><a href="#{APP_HOST}/users/verify_email?token=#{token}" target="_blank">马上验证邮箱</a></td>
            </tr>
            <tr height="10">
              <td style="font-size: 12px; -webkit-font-smoothing: subpixel-antialiased;">&nbsp;</td>
            </tr>
            <tr height="20">
              <td style="font-family: 微软雅黑, 黑体, arial; font-size: 12px; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 55px;">如果您无法点击以上链接，请复制以下网址到浏览器里直接打开：</td>
            </tr>
            <tr height="30">
              <td style="font-family: 微软雅黑, 黑体, arial; font-size: 12px; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 65px; line-height: 18px;">#{APP_HOST}/users/verify_email?token=#{token}</td>
            </tr>
            <tr height="20">
              <td style="font-family: 微软雅黑, 黑体, arial; font-size: 12px; -webkit-font-smoothing: subpixel-antialiased; padding-left: 55px; padding-right: 55px;">如果您并未申请账号，可能是其他用户误输入了您的邮箱地址。请忽略此邮件，或与我们联系。</td>
            </tr>
          </tbody>
        </table>
      }
    end

    # response = send_mail
    # puts response.code
    # puts response.to_str

  end

  # extend ClassMethods
end
