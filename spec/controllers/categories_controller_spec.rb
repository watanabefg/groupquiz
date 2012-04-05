#encoding:UTF-8
require 'spec_helper'

describe CategoriesController do
  before(:each) do

  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "タイトルの検証" do
      get 'new'
      response.should have_selector('title', :content => 'カテゴリーの作成|Groupquiz:クイズで楽しく情報共有')
    end
    it "名前の検証" do
      get 'new'
      response.should have_selector("input[name='category[name]'][type='text']")
    end
  end

end
