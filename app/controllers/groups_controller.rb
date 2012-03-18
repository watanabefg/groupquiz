# encoding:UTF-8
class GroupsController < ApplicationController
  def new
    @group = Group.new
    @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
  end

  def show
    @group = Group.find(params[:id])
    @title = @group.title
  end

end
