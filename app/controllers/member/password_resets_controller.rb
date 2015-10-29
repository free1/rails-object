module Member
  class PasswordResetsController < ::ApplicationController

    def new
    end

    def create
      user = User.find_by_email(params[:session][:email])
      if user
        user.send_password_reset
        # todo
        flash[:success] = "重置密码已发送至邮箱"
        redirect_to root_path
      else
        flash.now[:error] = "无效的邮箱!"
        render 'new'
      end
    end

    # /password_resets/:password_reset_token/edit
    def edit
      @user = User.find_by_password_reset_token!(params[:id])
    end

    def update
      @user = User.find_by_password_reset_token!(params[:id])
      if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_path, :alert => "密码重置已过期！"
      elsif @user.update_attributes(user_params)
        redirect_to root_path, :notice => "密码已重置！"
      else
        render :edit
      end
    end

    private

      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end

  end
end