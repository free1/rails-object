# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'weixin_test'
set :repo_url, 'git@gitlab.com:freeloverails/weixin_test.git'
# set :repo_url, 'git@gitcafe.com:free1/weixin_test.git'
# set :git_https_username, 'username'
# set :git_https_password, 'password'

set :deploy_user, "deploy"
set :use_sudo, false
set :user, "deploy"

# role
set :filter, :roles => %w{app web db}

# rbenv
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.2'
# # in case you want to set ruby version from the file:
# # set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# asset migrate
set :migration_role, 'db'
set :assets_roles, [:web, :app]

# unicorn
set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_roles, [:web, :app]
set :unicorn_rack_env, "production"

# set :rails_env, :production

set :stage, :production

# ssh_options[:forward_agent] = true
# ssh_options[:port] = 1000
set :ssh_options, {:forward_agent => true}

# Default branch is :master
set :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"

set :default_stage, "production"
# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/sunspot.yml}
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system solr/data solr/pids}
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :bundle_binstubs, nil
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# whenever
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, %w{app web db}

# sidekiq
set :sidekiq_pid, "./tmp/pids/sidekiq.pid"
set :sidekiq_log, "log/sidekiq.log"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end


before 'deploy:check:linked_files', 'deploy:create_linked_files'
namespace :deploy do
  desc '当linked_file不存在时自动创建空文件'
  task :create_linked_files do
    next unless any? :linked_files
    on release_roles :all do |host|
      linked_files(shared_path).each do |file|
        unless test "[ -f #{file} ]"
          execute :touch, file
        end
      end
    end
  end
end

# thinking_sphinx
# set :thinking_sphinx_roles, :db
# set :thinking_sphinx_rails_env, -> { fetch(:rails_env) || fetch(:stage) }

# sunspot
# namespace :deploy do
#   before :updated, :setup_solr_data_dir do
#     on roles(:app) do
#       unless test "[ -d #{shared_path}/solr/data ]"
#         execute :mkdir, "-p #{shared_path}/solr/data"
#       end
#     end
#   end
# end


# namespace :solr do
  
#   %w[start stop].each do |command|
#     desc "#{command} solr"
#     task command do
#       on roles(:app) do
#         solr_pid = "#{shared_path}/pids/sunspot-solr.pid"
#         if command == "start" or (test "[ -f #{solr_pid} ]" and test "kill -0 $( cat #{solr_pid} )")
#           within current_path do
#             with rails_env: fetch(:rails_env, 'production') do
#               execute :bundle, 'exec', 'sunspot-solr', command, "--port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids --solr-home=#{current_path}/solr"
#             end
#           end
#         end
#       end
#     end
#   end
  
#   desc "重启 sunspot"
#   task :restart do
#     invoke 'solr:stop'
#     invoke 'solr:start'
#   end
  
#   after 'deploy:finished', 'solr:restart'
  
#   desc "reindex sunspot"
#   task :reindex do
#     invoke 'solr:stop'
#     on roles(:app) do
#       execute :rm, "-rf #{shared_path}/solr/data"
#     end
#     invoke 'solr:start'
#     on roles(:app) do
#       within current_path do
#         with rails_env: fetch(:rails_env, 'production') do
#           info "Reindexing Solr database"
#           execute :bundle, 'exec', :rake, 'sunspot:solr:reindex[,,true]'
#         end
#       end
#     end
#   end

# end

# god
# namespace :god do
#   def god_is_running
#     capture(:bundle, "exec god status > /dev/null 2>&1 || echo 'god not running'") != 'god not running'
#   end
 
#   # Must be executed within SSHKit context
#   def config_file
#     "#{release_path}/config/god/init.god"
#   end
 
#   # Must be executed within SSHKit context
#   def start_god
#     execute :bundle, 'exec', :sudo, "god -c #{config_file}"
#   end
 
#   desc "Start god and his processes"
#   task :start do
#     on roles(:web) do
#       within release_path do
#         with RAILS_ENV: fetch(:rails_env) do
#           start_god
#         end
#       end
#     end
#   end
 
#   desc "Terminate god and his processes"
#   task :stop do
#     on roles(:web) do
#       within release_path do
#         if god_is_running
#           execute :bundle, "exec god terminate"
#         end
#       end
#     end
#   end
 
#   desc "Restart god's child processes"
#   task :restart do
#     on roles(:web) do
#       within release_path do
#         with RAILS_ENV: fetch(:rails_env) do
#           if god_is_running
#             execute :bundle, "exec god load #{config_file}"
#             execute :bundle, "exec god restart"
#           else
#             start_god
#           end
#         end
#       end
#     end
#   end
# end

# after "deploy:updated", "god:restart"

# namespace :deploy do
#   desc "after setup"
#   task :setup_config do
#     on roles(:all) do
#       execute "#{fetch(:sudo)} ln -nfs #{fetch(:current_path)}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
#       execute "#{fetch(:sudo)} ln -nfs #{fetch(:current_path)}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
#       execute "#{fetch(:sudo)} mkdir -p #{fetch(:shared_path)}/config"
#       p File.read("config/database.yml"), "#{fetch(:shared_path)}/config/database.yml"
#       p "modify file #{fetch(:shared_path)}."
#     end
#   end
#   after :started, :setup_config
# end
