class NewApi::V2::HomeController < NewApi::V2::BaseController

  def index
    @hot_products = Product.hot.order(id: :desc).last(8)
  end

end
