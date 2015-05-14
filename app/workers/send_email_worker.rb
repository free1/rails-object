class SendEmailWorker
  include Sidekiq::Worker

  # sidekip_options :queue => :send_email, :retry => 6, :backtrace => false

  # SendEmailWorker.perform_async('bob', 5)
  # SendEmailWorker.perform_in(5.minutes, 'bob', 5)
  # User.delay.do_some_stuff(current_user.id, 20)
  def perform(name, count)
    puts 'Doing hard work'
  end
end