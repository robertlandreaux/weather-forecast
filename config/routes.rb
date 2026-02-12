require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  res_browser =
    Rack::Builder.new do
      use Rack::Auth::Basic do |username, password|
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(username),
          ::Digest::SHA256.hexdigest(ENV["ADMIN_USERNAME"])
        ) &
          ActiveSupport::SecurityUtils.secure_compare(
            ::Digest::SHA256.hexdigest(password),
            ::Digest::SHA256.hexdigest(ENV["ADMIN_PASSWORD"])
          )
      end

      map "/" do
        run RailsEventStore::Browser
      end
    end

  mount res_browser => "/res"

  Sidekiq::Web.use(
    Rack::Session::Cookie,
    secret: ENV["RACK_SESSION_SECRET"],
    same_site: :strict,
    max_age: 86400
  )

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(ENV["ADMIN_USERNAME"])
    ) &
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(ENV["ADMIN_PASSWORD"])
      )
  end

  mount Sidekiq::Web => "/sidekiq"

  get "up" => "rails/health#show", :as => :rails_health_check

  namespace :api, constraints: {format: :json} do
    resources :locations, only: [:create]
    post "forecast", to: "forecasts#forecast"
  end
end
