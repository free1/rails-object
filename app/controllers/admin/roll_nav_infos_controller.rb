module Admin
	class RollNavInfosController < BaseController

		def index

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

		private

			def roll_nav_info_params
				params.require(:roll_nav_info).permit(:cover_path, :weight)
			end
	end
end