class Api::V1::ApplicationController < ActionController::API
    before_action :cors_set_access_control_headers
    before_action :authorize_request 
   

   
  # attr_reader :current_user

  private
  
  #allow access to heroku
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # Check for valid request token and return user
  def authorize_request
    @current_user = (Api::V1::AuthorizeApiRequest.new(request.headers).call)[:user]
  end

end
