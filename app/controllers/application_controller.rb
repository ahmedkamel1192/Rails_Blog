class ApplicationController < ActionController::Base
    before_action :cors_set_access_control_headers
    protect_from_forgery with: :exception

    def authenticate_user
    if (current_user.present?) 
       redirect_to('/')
    end
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
  
  #allow access to heroku
  def cors_set_access_control_headers
  		headers['Access-Control-Allow-Origin'] = '*'
	end

end
