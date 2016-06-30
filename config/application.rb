require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Loveaquote
  class Application < Rails::Application
    config.time_zone = 'Kolkata'
    root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
      config.sass.load_paths << bower_path
      config.assets.paths << bower_path
      config.assets.paths << Rails.root.join("app", "assets", "fonts")
    end

    config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
    ::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max
        
    config.active_record.raise_in_transactional_callbacks = true
    config.exceptions_app = self.routes
    
    config.active_job.queue_adapter = :delayed_job    
  end
end