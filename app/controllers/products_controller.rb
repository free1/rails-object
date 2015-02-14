class ProductsController < ApplicationController

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = current_user.products.build
	end

	def create
		@product = current_user.products.build(product_params)

		if @product.save
			flash[:success] = "发布成功"
      		redirect_to product_path(@product)
		else
			flash.now[:danger] = "发布失败"
			render 'new'
		end
	end

	private

		def product_params
			params.require(:product).permit(:name, :describe, :cover_path)
		end

end
