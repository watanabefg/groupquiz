class UsersController < ApplicationController
  def index
    @users = User.find(:all)
  end

  def callback
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
  end
end
