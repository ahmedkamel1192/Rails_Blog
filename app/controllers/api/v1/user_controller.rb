# frozen_string_literal: true
class Api::V1::UserController < Api::V1::ApplicationController
 

  def index
    @users = User.all
    render json:  @users

  end

  def my_favourite
    user = User.find(current_user.id)
    @favourites = user.favourite_articles
    render json: @favourites
  end

  def follow
    user = User.where(id: params[:id])
    if user.count > 0
      user = User.find(params[:id])
      if user.id != current_user.id
        user.followers << current_user
        current_user.count_followees += 1
        user.count_followers += 1
        user.save
        current_user.save
        render json: 'Followed Succesfully'
      else
        render json: "You Can't Follow your self"
      end
    else
      render json: 'User not found'
    end
  end

  def unfollow
    user = User.where(id: params[:id])
    if user.count > 0
      user = User.find(params[:id])
      if user.id != current_user.id
          user.followers.delete(current_user)
          current_user.count_followees -= 1
          user.count_followers -= 1
          user.save
          current_user.save
          render json: 'Unfollowed Succesfully'
      else
        render json: "You Can't Unfollow your self"
      end
    else
      render json: "User not found"

    end
  end


  def my_followees_articles
    @followees=current_user.followees
    render json: @followees

  end

  def my_followers_list
    @followers_list=current_user.followers
    render json: @followers

  end

  def my_followed_list
    @followed_list=current_user.followees
    render json: @followed_list
  end

end

