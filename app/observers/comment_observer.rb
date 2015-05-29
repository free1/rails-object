class CommentObserver < ActiveRecord::Observer
	observe :comment

  def after_create(record)
    commentable = record.commentable
    # 发送通知
    NotificationWork.perform_async(commentable.user.id, record.user_id, commentable.id, commentable.model_name.name, 'comment')
    # 创建动态
    record.delay.create_activity(:create, owner: record.user, recipient: commentable)
    # 发送通知提示
    MessageBus.delay.publish "/channel/#{commentable.user.id}", {unread_count: commentable.user.notifications.unread.count + 1}
  end
end