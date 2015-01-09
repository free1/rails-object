module V1
  module WeiXin
    class Test < Grape::API
      version 'v1', using: :path

      get "/test" do
        p "----"
        p get_request_ip
      end
    end
  end
end
