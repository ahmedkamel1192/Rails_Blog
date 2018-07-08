class SessionController < ApplicationController
    before_action :logged_in , except: :destroy
    # skip_before_action :verify_authenticity_token  , :only => [:create ]
    def new
        # render the login form
      end
    
      def create
        # @user = User.find_by("LOWER(email) = ?", user_params[:email].downcase)
        @user =AuthenticateUser.new(user_params[:email], user_params[:password]).user
        # if @user.present? && @user.authenticate(user_params[:password])
         if @user
          cookies.permanent.signed[:user_id] = @user.id
          redirect_to ('/ ')

          # respond_to do |format|
          #   format.html { redirect_to ('/') }
          #   format.json { }
          # end
        # elsif !@user.present?
        #   redirect_back fallback_location: new , notice: 'Un-regeistered user'
        else
          redirect_back fallback_location: new , notice: 'Invalid Credentials'
        end
      end
    
      def destroy
        cookies.delete(:user_id)
        redirect_to ('/signin')
      end
    
      private

      def logged_in
        if (current_user.present?) 
           redirect_to('/')
        end
      end
    
      def user_params
        params.require(:user).permit(:email, :password)
      end
end
