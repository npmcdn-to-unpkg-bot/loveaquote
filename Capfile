require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'whenever/capistrano'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/puma/monit'
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'
require 'capistrano/sitemap_generator'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }