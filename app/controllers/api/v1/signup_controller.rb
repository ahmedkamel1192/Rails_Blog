class Api::V1::SignupController < Api::V1::ApplicationController

  skip_before_action :authorize_request, only: :create
    
  def create
      user = User.create!(user_params)
      if user.save
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      else
        response ={message: Message.signup_error}
      end
     render json: response
    end
  
    private
  
    def user_params
      params.permit(:email, :password)
    end
end