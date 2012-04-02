# encoding:UTF-8
require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'callback'" do
    it "returns http success" do
      get 'callback'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "returns http success" do
      get 'edit', :id => @user
      response.should be_success
    end
    it "タイトルの検証" do
      get 'edit', :id => @user
      response.should have_selector(
        "title", :content => "ユーザー情報の編集|Groupquiz:クイズで楽しく情報共有"
      )
    end
    it "名前入力欄があること" do
      get 'edit', :id => @user
      response.should have_selector("input[name='user[name]'][type='text']")
    end
    it "性別入力欄があること" do
      get 'edit', :id => @user
      response.should have_selector("input[name='user[sex_id]'][type='radio']")
    end
    it "メールアドレス入力欄があること" do
      get 'edit', :id => @user
      response.should have_selector("input[name='user[email_address]'][type='text']")
    end
    it "パスワード入力欄があること" do
      get 'edit', :id => @user
      response.should have_selector("input[name='user[password]'][type='password']")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "アップデート成功" do
      put 'update', :id => @user
      response.should redirect_to(user_path(assigns(:user)))
    end
    it "アップデート失敗" do
      @attr = {:name => '', :password => '', :sex_id => '', :email_address => ''}
      put 'update', :id => @user, :user => @attr
      response.should render_template('edit')
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      @sex = Factory(:sex)
    end
    describe "サインインしていなければアクセス禁止" do
      it "サインインページにリダイレクトされること" do
        get 'show', :id => @user
        response.should redirect_to(signin_path)
      end
    end
    describe "サインインしている場合" do
      controller.sign_in(@user)
      it "returns http success" do
        get 'show', :id => @user
        response.should be_success
      end
    end
  end

  describe "GET 'destroy'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "returns http success" do
      delete 'destroy', :id => @user
      response.should redirect_to 'index'
    end
    describe "削除成功" do
      it "ユーザーが1件減っていること" do
        lambda do
          delete 'destroy', :id => @user
        end.should change(User, :count).by(-1) 
      end
    end
    describe "削除失敗" do
      it "ユーザーが削除されていないこと" do
        wrong_user = Factory(:user, :name => "Sabrou")
        controller.sign_in(wrong_user)

        delete :destroy,  :id => @user
        response.should redirect_to(root_path)
      end
    end
  end
end
