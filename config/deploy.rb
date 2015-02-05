# config valid only for current version of Capistrano
lock '3.3.5'

# set :ssh_options, {
#   keys: %w(~/.ssh/id_rsa.pub),
#   forward_agent: true,
#   auth_methods: %w(password)
# }

set :stages, ["production"]

set :application, 'weixin_test'
set :repo_url, 'https://gitcafe.com/free1/weixin_test.git'

set :user, "deploy"
set :use_sudo, true

# set :rvm_type, :system                     # Defaults to: :auto
# set :rvm_ruby_version, '2.0.0-p247'      # Defaults to: 'default'
# set :rvm_custom_path, '~/.myveryownrvm'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.2'

# Default branch is :master
ask :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/weixin_test'

# set :default_stage, "production"
# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc "之后执行"
  task :setup_config do
    on roles(:all) do |host|
      run "#{try_sudo} ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      run "#{try_sudo} ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
      run "mkdir -p #{shared_path}/config"
      put File.read("config/database.yml"), "#{shared_path}/config/database"
      put "修改文件 #{shared_path}."
    end
  end
  after "deploy:setup", "deploy:setup_config"
end
