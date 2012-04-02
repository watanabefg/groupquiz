# encoding:UTF-8
class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => [:index]
  def index
    @users = User.find(:all)
    @title = "ユーザーログイン"
  end

  def callback
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name + "さんの情報を見る"
    respond_to do |format|
      format.html
    end
  end

  def edit
    @title = "ユーザー情報の編集|Groupquiz:クイズで楽しく情報共有"
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user]) 
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to 'index', notice: 'User was deleted.'
  end
end
