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

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

end
