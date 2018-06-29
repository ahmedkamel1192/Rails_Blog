class UserController < ApplicationController
    before_action :current_user
    before_action :authorized_user 

    def my_favourite
        user=User.find(@current_user.id)
        @favourites = user.favourite_articles
    end



    private

    def authorized_user
        if @current_user.blank?
          redirect_to ('/signin')
        end
      end
  
    def allowed_user
        if @current_user.id != @article.user_id
           respond_to do |format|
            format.html {redirect_to articles_path, notice: 'You are not authorized' }
           end
        end
      end
end
