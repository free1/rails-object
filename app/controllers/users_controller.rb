class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      sign_in @user
      flash[:success] = "注册成功"
      redirect_to root_path
    else
      flash.now[:danger] = "注册失败"
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
