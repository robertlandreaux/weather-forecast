module BasicAuthHelper
  def http_login
    user = ENV["ADMIN_USERNAME"]
    password = ENV["ADMIN_PASSWORD"]
    request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
  end
end
