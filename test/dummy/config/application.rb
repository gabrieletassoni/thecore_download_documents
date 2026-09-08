require_relative 'boot'

require 'rails/all'

# Stub config.assets — sprockets/propshaft is not in this gem's bundle, but
# thecore_backend_commons's config/initializers/application_config.rb (a real transitive
# dependency, via thecore_ui_commons) unconditionally sets `config.assets.prefix` at boot.
# Same stub as thecore_backend_commons's and thecore_ui_rails_admin's own dummy apps use for
# this identical problem — see either of those gems' test/dummy/config/application.rb.
stub_class = Class.new do
  def method_missing(name, *args, &block)
    name_s = name.to_s
    return false if name_s.end_with?("?")
    return nil   if name_s.end_with?("=") || args.any? || block
    ivar = :"@_s_#{name_s.gsub(/\W/, "_")}"
    instance_variable_get(ivar) || instance_variable_set(ivar, self.class.new)
  end
  def respond_to_missing?(name, *) = name.to_s != "to_ary"
end

Rails::Application::Configuration.prepend(Module.new do
  define_method(:assets) { @_stub_assets ||= stub_class.new }
end)

Bundler.require(*Rails.groups)
require "thecore_download_documents"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

