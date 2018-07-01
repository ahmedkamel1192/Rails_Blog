class Api::V1::SignupController < Api::V1::ApplicationController

  skip_before_action :authorize_request, only: :create
    
  def create
    if !User.find_by_email(user_params[:email])
      user = User.create!(user_params)
      if user.save
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      else
       response={ message: 'error while creating account' }
      end
     render json: response
    else
      render json: {message: 'account already exist'}
    end
    end
  
    private
  
    def user_params
      params.permit(:email, :password)
    end
end