module Admin
	class CategoriesController < BaseController

		def index
			@categories = Category.paginate(page: params[:page], per_page: 20)	
		end

		def new
			@category = Category.new
		end

		def create
			@category = Category.new(category_params)

			if @category.save
				flash[:success] = "创建成功"
				redirect_to admin_categories_path
			else
				flash.now[:danger] = @category.errors.messages
				render 'new'
			end
		end

		private

			def category_params
				params.require(:category).permit(:name)
			end

	end
end