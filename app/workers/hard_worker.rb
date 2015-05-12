class HardWorker
  include Sidekiq::Worker

  # HardWorker.perform_async('bob', 5)
  def perform(name, count)
    puts 'Doing hard work'
  end
end