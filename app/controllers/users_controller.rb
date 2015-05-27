class UsersController < ApplicationController
  before_action :find_user, only: [ :show, :edit, :update, :following, :followers ]
  before_action :signed_in_user, except: [ :show, :index, :new, :create ]
  invisible_captcha only: [:create, :update], honeypot: :subtitle

  def show
  end

  def index
    @users = User.includes(:info).paginate(page: params[:page], per_page: 12)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = '账号注册成功，验证邮箱可以体验更多功能哦~'
      redirect_to root_path
    else
      flash.now[:danger] = '账号注册失败!'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update!(user_params)
      flash[:success] = '修改成功~'
      redirect_to :back
    else
      flash.now[:danger] = '修改失败!'
      render 'edit'
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

  def following
    @title = '关注'
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = '关注者'
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def feeds
    @feeds = current_user.all_feeds.paginate(page: params[:page])
  end

  def products
    user = User.find(params[:id])
    @products = user.products.paginate(page: params[:page], per_page: 16)
    render 'products/index'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar_path, 
                                    :is_email_push, :tag_tokens, :subtitle,
                                    info_attributes: [:gender, :resume, :website, :user_id, :id],
                                    wechat_info_attributes: [:public_name, :number, :qr_code, :keyword, :user_id])
    end

    def find_user
      @user = User.find(params[:id])
    end

end
