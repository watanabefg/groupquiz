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

end
