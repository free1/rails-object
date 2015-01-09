module V1
  module WeiXin
    class Test < Grape::API
      version 'v1'

      get "/articles/:id/events" do
        p "----"
      end
    end
  end
end
