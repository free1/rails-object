module Admin
	class CategoriesController < BaseController
		before_action :find_category, only: [ :destroy, :change_weight ]

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

		def destroy
			@category.destroy
			redirect_to :back
		end

		def change_weight
			if @category.update_attribute(:weight, params[:weight])
				render status: 200, nothing: true
			else	
				render status: 500, nothing: true
			end
		end

		private

			def category_params
				params.require(:category).permit(:name)
			end

			def find_category
				@category = Category.find(params[:id])
			end

	end
end