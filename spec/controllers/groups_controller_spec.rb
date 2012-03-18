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
      response.should have_selector(
        "title", :content => "グループの作成|Groupquiz:クイズで楽しく情報共有"
      )
    end
    it "タイトル入力欄があること" do
      get 'new'
      response.should have_selector("input[name='group[title]'][type='text']")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @group = Factory(:group)
      @current_user = {:name => "Hironori Watanabe"}
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

  describe "POST 'create'" do
    describe "登録させないケースの検証" do 
      before(:each) do 
        @attr = {:user_id => 1, :title => "" } 
      end 
      it "グループを登録しないこと" do 
        lambda do 
          post :create, :group => @attr
        end.should_not change(Group, :count)
      end 
      it "新規登録ページに戻ること(タイトル検証)" do 
        post :create, :group => @attr
        response.should have_selector("title", :content => "グループの作成|Groupquiz:クイズで楽しく情報共有") 
      end 
      it "新規登録ページに戻ること(テンプレート検証)" do 
        post :create,  :group => @attr
        response.should render_template('new') 
      end 
    end #登録させないケースの検証 

    describe "登録に成功するケースの検証" do 
      before(:each) do 
        @attr = { :user_id => 1, :title => "グループ作成のテスト"} 
      end 
      it "DBに新規グループを登録していること" do 
        lambda do 
          post :create, :group => @attr
        end.should change(Group, :count).by(1) 
      end 
      it "グループページに遷移していること" do 
        post :create, :group => @attr
        response.should redirect_to(group_path(assigns(:group))) 
      end 
      it "登録に成功した旨をユーザーに表示していること" do 
        post :create, :group => @attr
        flash[:success].should =~ /登録に成功しました/ 
      end
    end #登録に成功するケースの検証 
  end

end
