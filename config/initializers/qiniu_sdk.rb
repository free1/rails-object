#!/usr/bin/env ruby

require 'qiniu'

Qiniu.establish_connection! :access_key => ENV["qiniu_access_key"],
                            :secret_key => ENV["qiniu_secret_key"]