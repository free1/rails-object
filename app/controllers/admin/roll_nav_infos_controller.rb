module Admin
	class RollNavInfosController < BaseController
		before_action :find_roll_nav_info, only: [:destroy]

		def index
			@roll_nav_infos = RollNavInfo.order(id: :desc).paginate(page: params[:page], per_page: 30)
		end

		def new
			@roll_nav_info = RollNavInfo.new
		end

		def create
			@roll_nav_info = RollNavInfo.new(roll_nav_info_params)
			if @roll_nav_info.save
				flash[:success] = "创建成功!"
				redirect_to admin_roll_nav_infos_path
			else
				render 'new'
			end
		end

		def destroy
			@roll_nav_info.destroy
			redirect_to :back
		end

		def change_weight
			@roll_nav_info = RollNavInfo.find(params[:roll_nav_info_id])

			if @roll_nav_info.update_attribute(:weight, params[:weight])
				flash[:success] = "更新成功"
			else
				flash[:error] = "更新失败"
			end
			redirect_to :back
		end

		private

			def roll_nav_info_params
				params.require(:roll_nav_info).permit(:cover_path, :weight)
			end

			def find_roll_nav_info
				@roll_nav_info = RollNavInfo.find(params[:id])
			end
	end
end