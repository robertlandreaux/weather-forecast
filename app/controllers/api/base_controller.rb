module Api
  class BaseController < ApplicationController
    before_action :http_basic_authenticate_with, name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  end
end
