class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      @user.send_verify_email
      flash[:success] = '账号注册成功，验证邮箱可以体验更多功能哦~'
      redirect_to root_path
    else
      flash.now[:danger] = '账号注册失败!'
      render 'new'
    end
  end

  def verify_email
    if params[:token].present? && (user = User.find_by_verify_token(params[:token]))
      if user.is_verify_email?
        redirect_to root_path, flash: { info: '不需要重复验证邮箱' }
      else
        user.toggle!(:is_verify_email)
        redirect_to root_path, flash: { success: '邮箱验证成功~' }
      end
    else
      redirect_to new_user_path, flash: { danger: '请先注册账号再进行此操作!' }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
