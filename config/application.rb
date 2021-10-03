require_relative 'boot'

require 'rails/all'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VisableBank
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.api_only = true

    config.autoload_paths += Dir[Rails.root.join('app', 'serializers', '{**/*.rb}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services', '{**/*.rb}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers', '**/*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '**/*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'errors', '**/*.rb')]

    config.hosts.clear
  end
end
