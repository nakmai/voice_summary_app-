require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VoiceSummaryApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # API設定 - 環境変数から読み込み
    config.azure_speech_key = ENV['AZURE_SPEECH_KEY']
    config.azure_speech_region = ENV['AZURE_SPEECH_REGION']
    config.openai_api_key = ENV['OPENAI_API_KEY']
    config.openai_model = ENV['OPENAI_MODEL'] || 'gpt-3.5-turbo'
  end
end
