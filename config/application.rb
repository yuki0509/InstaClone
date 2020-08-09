require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # css・jsファイル,ルーティング,testファイル,helperファイルが生成されないように設定
    config.generators do |g|
      g.assets false
      g.skip_routes true
      g.test_framework false
      g.helper false
    end

    # Railsが表示の際に扱うタイムゾーン
    config.time_zone = 'Asia/Tokyo'

    # ActiverecordがDBへの読み書きを行う際のタイムゾーン
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja
    # config/locale以下のファイルが読み込めるようにパスを通す
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
