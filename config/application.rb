require_relative 'boot'

require "rails"

require "active_model/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RoamBackend
  class Application < Rails::Application
    config.load_defaults 5.2

    config.api_only = true

    config.autoload_paths << Rails.root.join('lib')
  end
end
