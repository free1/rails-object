class NotificationWork
  include Sidekiq::Worker

  sidekiq_options :queue => :notification_work, :retry => 6, :backtrace => false

  # NotificationWork.perform_async(@commentable, current_user.id)
  # NotificationWork.perform_in(5.minutes, @commentable, current_user.id)
  # User.delay.do_some_stuff(current_user.id, 20)
  def perform(receiver_id, sender_id, notifiable_id, notifiable_type, content)
    Notification.create \
    	sender_id: sender_id,
    	receiver_id: receiver_id,
    	notifiable_id: notifiable_id,
    	notifiable_type: notifiable_type,
    	content: content
  end
end