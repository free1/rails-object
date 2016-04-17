class NewApi::V2::SearchController < NewApi::V2::BaseController

  def product_search
    @products = Product.product_search(params[:query]).paginate(page: params[:page], per_page: params[:per_page]).records
    render 'products/index'
  end

end
