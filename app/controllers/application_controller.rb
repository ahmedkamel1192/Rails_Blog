class ApplicationController < ActionController::Base
    # protected

  def authenticate_user
    if (current_user.present?) 
       redirect_to('/')
    end
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

end
