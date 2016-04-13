class NewApi::V2::CategoriesController < NewApi::V2::BaseController

  def index
    @categories = Category.all
  end

end
