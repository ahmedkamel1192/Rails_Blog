# frozen_string_literal: true
class Api::V1::UserController < Api::V1::ApplicationController
 

  def index
    @users = User.all
    render json:  @users

  end

  def my_favourite
    # user = User.find(@current_user.id)
    @favourites = @current_user.favourite_articles
    render json: @favourites
  end

  def follow
      
    user = User.find_by(id: params[:id])
    if user
      if user.id != @current_user.id
        if !user.followers.include? @current_user
        user.followers << @current_user
        @current_user.count_followees += 1
        user.count_followers += 1
        user.save
        @current_user.save

        render json: {message: 'Followed Succesfully'}
        else 
          render json: {message: 'already followed'}
        end
      else
        render json:{message:  "You Can't Follow your self"}
      end
    else
      render json: {message: 'User not found'}
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
          render json:{message: 'Unfollowed Succesfully'}
        else 
          render json: {message: 'already unfollowed'}
        end
      else
        render json: {message: "You Can't Unfollow your self"}
      end
    else
      render json:{message: "User not found"}

    end
  end


  def my_followees_articles
     @data=[]
     @followees=@current_user.followees
     @followees.each do |followee|
      followee.articles.each do |article|
        @data<<article
      end
     end
    render json: {data: @data }

  end

  def my_followers_list
    @followers_list=@current_user.followers
    render json:  {data: @followers }

  end

  def my_followed_list
    @followed_list=@current_user.followees
    render json:  {data: @followed_list }
  end

end

