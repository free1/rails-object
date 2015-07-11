class NewApi::V2::HomeController < NewApi::V2::BaseController

  def index
    @hello = "hello world"
    render "home/index"
  end

  def show
    @hello = "world"
    render json: @hello
  end
end
