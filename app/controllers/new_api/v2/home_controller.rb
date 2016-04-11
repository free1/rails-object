class NewApi::V2::HomeController < NewApi::V2::BaseController

  def index
    @hot_products = Product.hot.order(id: :desc).last(8)
    @roll_nav_infos = RollNavInfo.order(:weight).last(6)
  end

end
