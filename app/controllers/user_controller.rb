# frozen_string_literal: true

class UserController < ApplicationController
  before_action :current_user
  before_action :authorized_user

  def index
    @users = User.all
  end

  def my_favourite
    user = User.find(@current_user.id)
    @favourites = user.favourite_articles
  end

  def follow
    user = User.where(id: params[:id])
    if user.count > 0
      user = User.find(params[:id])
      if user.id != @current_user.id
        user.followers << @current_user
        @current_user.count_followees += 1
        user.count_followers += 1
        user.save
        @current_user.save
        respond_to do |format|
          format.html { redirect_to all_user_url, notice: 'Followed Succesfully' }
        end
      else
        respond_to do |format|
          format.html { redirect_to all_user_url, notice: "You Can't Follow your self" }
        end
          end
    else
      respond_to do |format|
        format.html { redirect_to all_user_url, notice: 'User not found' }
      end
    end
  end

  def unfollow
    user = User.where(id: params[:id])
    if user.count > 0
      user = User.find(params[:id])
      if user.id != @current_user.id
          user.followers.delete(@current_user)
          @current_user.count_followees -= 1
          user.count_followers -= 1
          user.save
          @current_user.save
          respond_to do |format|
            format.html { redirect_to all_user_url, notice: 'Unfollowed Succesfully' }
          end
      else
          respond_to do |format|
            format.html { redirect_to all_user_url, notice: "You Can't Unfollow your self" }
          end
      end
    else
          respond_to do |format|
            format.html { redirect_to all_user_url, notice: 'User not found' }
          end
    end
  end


  def my_followees_articles
    @followees=@current_user.followees
  end

  private

  def authorized_user
    redirect_to '/signin' if @current_user.blank?
    end

  def allowed_user
    if @current_user.id != @article.user_id
      respond_to do |format|
        format.html { redirect_to articles_path, notice: 'You are not authorized' }
      end
    end
    end
end

