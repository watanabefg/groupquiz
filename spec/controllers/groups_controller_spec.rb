# encoding: UTF-8
require 'spec_helper'

describe GroupsController do
  render_views
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "タイトルの検証" do
      get 'new'
      response.should have_selector("title", :content => "グループの作成|Groupquiz:クイズで楽しく情報共有")
    end
    it "タイトル入力欄があること" do
      get 'new'
      response.should have_selector("input[name='group[title]'][type='text']")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @group = Factory(:group)
    end
    it "returns http success" do
      get 'show', :id => @group
      response.should be_success
    end
    it "正しいグループを表示していること" do
      get 'show', :id => @group
      assigns(:group).should == @group
    end
    it "タイトルの検証" do
      get 'show', :id => @group
      response.should have_selector("title", :content => @group.title)
    end
  end # get 'show'

end
