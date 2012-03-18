# encoding:UTF-8
class GroupsController < ApplicationController
  def new
    @group = Group.new
    @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
  end

  def index
    @group = Group.all
    @title = "グループの一覧"
  end

  def ordergroup
    @group = Group.all(:order => 'title desc', :limit => 20)
    @title = "グループの一覧"
  end

  def orderowner
    @group = Group.all(:order => 'user_id desc', :limit => 20)
    @title = "グループの一覧"
  end

  def orderupdated
    @group = Group.all(:order => 'updated_at desc', :limit => 20)
    @title = "グループの一覧"
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "登録に成功しました"
      redirect_to @group
    else
      @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @user = @group.users
    @title = @group.title
  end

end
