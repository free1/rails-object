# config valid only for current version of Capistrano
lock '3.3.5'

# set :ssh_options, {
#   keys: %w(~/.ssh/id_rsa.pub),
#   forward_agent: true,
#   auth_methods: %w(password)
# }

# set :stages, ["production"]

set :application, 'weixin_test'
set :repo_url, 'git@gitlab.com:freeloverails/weixin_test.git'

set :deploy_user, "deploy"
set :use_sudo, false

# rbenv
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.2'
# # in case you want to set ruby version from the file:
# # set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# set :rails_env, :production

# set :stage, :production

server 'deploy@121.42.161.252', roles: [:all]
# role :app, %w{deploy@121.42.161.252}
# role :web, %w{deploy@121.42.161.252}
# role :db,  %w{deploy@121.42.161.252}

# Default branch is :master
set :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"

# set :default_stage, "production"
# Default value for :scm is :git
set :scm, :git

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
# set(:config_files, %w(
#   nginx.conf
#   database.example.yml
#   log_rotation
#   monit
#   unicorn.rb
#   unicorn_init.sh
# ))
set(:config_files, %w(
  nginx.conf
  database.example.yml
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}"
  },
  # {
  #   source: "log_rotation",
  #  link: "/etc/logrotate.d/#{fetch(:application)}"
  # },
  {
    source: "monit",
    link: "/etc/monit/conf.d/#{fetch(:application)}.conf"
  }
])


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

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


namespace :deploy do
  # make sure we're deploying what we think we're deploying
  # before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  # before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  # after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  before :finishing, 'deploy:restart_unicorn'
  desc "restart unicorn"
  task :restart_unicorn do
  	on roles(:all) do
      p "----------------------"
  		execute "cd #{current_path} && bundle exec rake assets:precompile RAILS_ENV=production && /etc/init.d/unicorn_weixin_test restart && bundle exec rake db:migrate RAILS_ENV=production"
  	end
  end

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  # before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  # after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  # after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
end