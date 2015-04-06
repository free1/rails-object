# 给url的id加密
# model:
# class MyModel < ActiveRecord::Base
#   include Obfuscate
#   def to_param
#     encrypt id
#   end
# end
# controller:
# MyModel.find MyModel.decrypt(params[:id])

require 'openssl'
require 'base64'

module Obfuscate
  def self.included(base)
    base.extend self
  end

  # 加密和解密对称算法
  def cipher
    OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  end

  # 暗号
  def cipher_key
    'free!'
  end

  # 加密
  def encrypt(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    Base64.encode64(c.update(value.to_s) + c.final)
  end

  # 解密
  def decrypt(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.update(Base64.decode64(value.to_s)) + c.final
  end
end