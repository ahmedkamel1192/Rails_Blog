class SessionController < ApplicationController
    before_action :authenticate_user , except: :destroy
    skip_before_action :verify_authenticity_token  , :only => [:create ]
    def new
        # render the login form
      end
    
      def create
        @user = User.find_by("LOWER(email) = ?", user_params[:email].downcase)
    
        if @user.present? && @user.authenticate(user_params[:password])
          cookies.permanent.signed[:user_id] = @user.id
          respond_to do |format|
            format.html { redirect_to ('/') }
            format.json { }
          end
        elsif !@user.present?
          redirect_back fallback_location: new , notice: 'Un-regeistered user'
        else
          redirect_back fallback_location: new , notice: 'Invalid Credentials'
        end
      end
    
      def destroy
        cookies.delete(:user_id)
        redirect_to ('/signin')
      end
    
      private
    
      def user_params
        params.require(:user).permit(:email, :password)
      end
end
