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
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
