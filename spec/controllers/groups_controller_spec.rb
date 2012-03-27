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

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @group = Factory(:group)
      @user = Factory(:user)
      @belongs_to_group = Factory(:belongs_to_group)
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
    it "正しいユーザーを表示していること" do
      get 'show', :id => @group
      assigns(:user).should == [@user]
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
      it "関連モデルにもデータが登録されていること" do
        lambda do 
          post :create, :group => @attr
        end.should change(BelongsToGroup, :count).by(1) 
      end
      it "登録に成功した旨をユーザーに表示していること" do 
        post :create, :group => @attr
        flash[:success].should =~ /登録に成功しました/ 
      end
    end #登録に成功するケースの検証 
  end

  describe "GET 'edit'" do
    before(:each) do
      @group = Factory(:group)
    end
    it "アクセスできること" do
      get :edit, :id => @group
    end
    it "タイトルの検証" do
      get :edit, :id => @group
      response.should have_selector("title", :content => "グループの編集|Groupquiz:クイズで楽しく情報共有")
    end
    it "タイトルフィールドが存在すること" do
      get :edit,  :id => @group
      response.should have_selector("input[name='group[title]'][type='text']")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @group = Factory(:group)
    end

    describe "更新に失敗するケースの検証" do
      before(:each) do
        @attr = { :title => ""}
      end
      it "設定変更ページを再表示すること" do
        put :update, :id => @group, :group => @attr
        response.should render_template('edit')
      end
      it "設定変更ページのタイトルであること" do
        put :update, :id => @group, :group => @attr
        response.should have_selector("title", :content => "グループの編集|Groupquiz:クイズで楽しく情報共有")
      end
    end #更新に失敗するケースの検証

    describe"更新に成功するケース" do
      before(:each) do
        @attr = { :title => "変更後のグループ" }
      end
      it "グループ情報が更新されていること" do
        put :update, :id => @group, :group => @attr
        @group.reload
        @group.title.should == @attr[:title]
      end
      it "グループ個別ページへ遷移すること" do
        put :update, :id => @group, :group => @attr
        response.should redirect_to(group_path(@group))
      end
    end #更新に成功するケースの検証
  end

  describe "PUT 'dropout'" do
    before(:each) do
      @group = Factory(:group)
      @user = Factory(:user)
      @belongs_to_group = Factory(:belongs_to_group)
      @attr = { :user_id => @user.id, :group_id => @group.id }
    end
    it "所属からはずすこと" do
      lambda do
        put :dropout, :id => @group.id, :group => @attr
      end.should change(BelongsToGroup, :count).by(-1) 
    end

    # "自分が管理者ではないケースの検証"は特になし
    describe "自分が管理者のケースの検証" do
      describe "次の管理者がいないケースの検証" do
        it "グループを削除すること" do
          lambda do
            put :dropout, :id => @group.id, :group => @attr
          end.should change(Group, :count).by(-1) 
        end
      end
      describe "次の管理者を決めるケースの検証" do
        it "グループの次の管理者を決める画面に遷移" do
          Factory(:belongs_to_group_next)
          put :dropout, :id => @group.id, :group => @attr
          response.should redirect_to(edit_group_path(assigns(:group))) 
        end
      end
    end
  end
end
