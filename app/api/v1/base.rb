module V1
  class Base < Grape::API
    version 'v1', using: :path
    prefix :api

    mount V1::WeiXin::Test
    mount V1::WeiXin::Posts
    mount V1::WeiXin::Users
    mount V1::WeiXin::Articles
  end
end
