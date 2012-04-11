#encoding:UTF-8
require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "redirectの確認" do
      get 'new'
      response.should redirect_to('/auth/facebook')
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      post 'create', :provider => 'facebook', :uid => '1'
      response.should redirect_to('/users/1')
    end
  end

  describe "GET 'destroy'" do
    it "redirectの確認" do
      get 'destroy'
      response.should redirect_to('/signin')
    end
  end

end
