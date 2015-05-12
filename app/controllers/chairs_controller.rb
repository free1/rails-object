class ChairsController < ApplicationController
	before_action :signed_in_user
	before_action :find_chair, only: [:edit, :update, :destroy]

	def index
		@chairs = Chair.order(id: :desc).paginate(page: params[:page], per_page: 20)
	end

	def new
		@chair = current_user.chairs.build
	end

	def create
		@chair = current_user.chairs.build(chair_params)

		if @chair.save
			flash[:success] = '创建成功!'
			redirect_to chairs_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @chair.update(chair_params)
			flash[:success] = '更新成功'
			redirect_to chairs_path
		else
			render 'edit'
		end
	end

	def destroy
		@chair.destroy
		redirect_to :back
	end

	private

		def chair_params
			params.require(:chair).permit(:title, :content)
		end

		def find_chair
			@chair = Chair.find(params[:id])
		end
end
