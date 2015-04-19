module V1
  class Base < Grape::API
    version 'v1', using: :path

    mount V1::WeiXin::Test
    mount V1::WeiXin::Posts
    mount V1::WeiXin::Users
  end
end
