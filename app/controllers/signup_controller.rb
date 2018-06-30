class SignupController < ApplicationController
    before_action :authenticate_user
   
    def new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        cookies.signed[:user_id] = @user.id
        redirect_to ('/ ')
      else
        redirect_back fallback_location: new , notice: 'Email already Exist'
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
