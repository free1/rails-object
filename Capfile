# Load DSL and set up stages
# require 'capistrano/setup'
# Include default deployment tasks
# require 'capistrano/deploy'
# require 'capistrano/passenger'

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'
require "whenever/capistrano"
# require 'thinking_sphinx/capistrano'
require 'capistrano/sidekiq'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
# Dir.glob('lib/capistrano/**/*.rb').each { |r| import r }

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
