# encoding:UTF-8
class UsersController < ApplicationController
  skip_before_filter :authenticate
  def index
    @users = User.find(:all)
    @title = "ユーザーログイン"
    @user_ranking = User.find_by_sql("SELECT name FROM users ORDER BY possession_medals DESC LIMIT 10")
    @group_ranking = Group.find_by_sql("SELECT title FROM belongs_to_groups INNER JOIN groups ON belongs_to_groups.group_id = groups.id GROUP BY group_id ORDER BY count(*) DESC LIMIT 5") 
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
