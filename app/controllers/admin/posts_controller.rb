class Admin::PostsController < Admin::BaseController
    inherit_resources

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(resource_params)

      if @post.save
        flash[:success] = "创建成功"
        redirect_to admin_posts_path
      else
        flash.now[:danger] = @post.errors.messages
        render 'new'
      end
    end

    protected
      def collection
        @expresses ||= end_of_association_chain.order(id: :desc).paginate(page: params[:page], per_page: 20)
      end
  
    private
      def resource_params
        params.require(:post).permit(
          :title,
          :content
        )
      end

end
