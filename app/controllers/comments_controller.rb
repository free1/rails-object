class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :load_commentable

  def create
  	@comment = @commentable.comments.build(comment_params)
  	@comment.user_id = current_user.id
  	if @comment.save
      # 发送通知
      NotificationWork.perform_async(@commentable.user.id, current_user.id, @commentable.id, @commentable.model_name.name, 'comment')
  		redirect_to @commentable
  	else
  		redirect_to :back
  	end
  end

  def destroy
  end

  private

  	def load_commentable
  		resource, id = request.path.split('/')[1, 2]
  		@commentable = resource.classify.constantize.find(id)
  	end

  	def comment_params
  		params.require(:comment).permit(:content)
  	end

end
