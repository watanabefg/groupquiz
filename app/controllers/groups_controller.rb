# encoding:UTF-8
class GroupsController < ApplicationController
  def new
    @group = Group.new
    @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
  end

  def index
    @group = Group.all(:order => 'created_at desc', :limit => 20)
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
    group_save = @group.save

    belongs = {
      "user_id" => params[:group]["user_id"],
      "group_id" => @group.id
    }
    @belongstogroup = BelongsToGroup.new(belongs)

    if group_save && @belongstogroup.save
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

  def edit
    @group = Group.find(params[:id])
    @title = "グループの編集|Groupquiz:クイズで楽しく情報共有"
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "グループ情報を更新しました。"
      redirect_to @group
    else
      @title = "グループの編集|Groupquiz:クイズで楽しく情報共有"
      render 'edit'
    end
  end

  def dropout
    @group = Group.find(params[:id])
    @user = @group.users
    # 関連モデルから削除する
    @belongstogroup = BelongsToGroup.
      where('user_id = ?', params[:group][:user_id]).
      where('group_id = ?', params[:id])
    BelongsToGroup.delete(@belongstogroup)
    redirect_to 'index'
  end

end
