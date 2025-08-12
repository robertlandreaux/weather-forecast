require "sidekiq/web"

Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  mount Sidekiq::Web => "/sidekiq"

  namespace :api, constraints: {format: :json} do
    get "forecast", to: "forecasts#current"
  end
end
