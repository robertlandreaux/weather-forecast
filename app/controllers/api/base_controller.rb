module Api
  class BaseController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include TypedParams::Controller

    http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

    rescue_from TypedParams::InvalidParameterError, with: ->(err) {
      render_bad_request err.message, source: err.path.to_s
    }
  end
end
