require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'features'" do
    it "returns http success" do
      get 'features'
      response.should be_success
    end
  end

  describe "GET 'plans'" do
    it "returns http success" do
      get 'plans'
      response.should be_success
    end
  end

end
