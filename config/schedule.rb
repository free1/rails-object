# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']

# set :output, "/var/log/cron_log.log"
set :output, "log/cron.log"

# 抓取任务
every 1.day, :at => '1:30 am' do
	rake "post:crawl_mrwu_post"
end
every 1.day, :at => '2:00 am' do
	rake "post:crawl_oszine_post"
end
every 1.day, :at => '2:30 am' do
	rake "post:crawl_ingchuang_post"
end
every 1.day, :at => '3:00 am' do
	rake "post:check_content"
end
every 1.day, :at => '3:30 am' do
	rake "post:check_title"
end
every 1.day, :at => '4:00 am' do
	rake "post:delete_short_post"
end

# 搜索更新
every 1.day, :at => '7:10 am' do
  # rake "ts:index"
  rake "sunspot:solr:reindex"
end

# 定时备份数据
every :sunday, :at => '5:50 am' do
	command 'cd /home/deploy/apps/weixin_test/current/ && bundle exec backup perform -t my_backup --config-file config/backup/config.rb'
end

# 转存任务
every 1.minutes do
	runner "Post.sum_watch_count"
end