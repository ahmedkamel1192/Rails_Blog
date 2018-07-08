# frozen_string_literal: true

class UserController < ApplicationController
  before_action :current_user , :authorized_user

  def index
    @users = User.all
  end

  def my_favourite
    # user = User.find(@current_user.id)
    @favourites = @current_user.favourite_articles
  end

  def follow
    # user = User.where(id: params[:id])
    # if user.count > 0
      
    user = User.find_by(id: params[:id])
    if user
      if user.id != @current_user.id
        if !user.followers.include? @current_user
          user.followers << @current_user
          @current_user.count_followees += 1
          user.count_followers += 1
          user.save
          @current_user.save
          notice="Followed Succesfully"   
        else
          notice="already Followed"
        end
      else
        notice="You Can't Follow your self"
      end
    else
     notice = "User not found"
    end
    respond_to do |format|
      format.html { redirect_back fallback_location: all_user_url, notice: notice}
    end
  end

  def unfollow
      user = User.find_by(id: params[:id])
      if user
        if user.id != @current_user.id
          if user.followers.include? @current_user
            user.followers.delete(@current_user)
            @current_user.count_followees -= 1
            user.count_followers -= 1
            user.save
            @current_user.save
            notice="Unfollowed Succesfully"
          else
            notice="already Unfollowed"         
          end
        else
          notice="You Can't Unfollow your self" 
        end
      else  
        notice="User not found"
      end
      respond_to do |format|
        format.html { redirect_back fallback_location: all_user_url, notice: notice }
      end
  end


  def my_followees_articles
    # @followees=@current_user.followees
    @articles=[]
    @followees=@current_user.followees
    @followees.each do |followee|
     followee.articles.each do |article|
       @articles<<article
     end
    end
  end

  def my_followers_list
    @followers_list=@current_user.followers
  end

  def my_followed_list
    @followed_list=@current_user.followees
  end

  private

  def authorized_user
    redirect_to '/signin' if @current_user.blank?
    end

end

