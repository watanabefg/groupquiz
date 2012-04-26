# encoding:UTF-8
require 'spec_helper'

describe Answer do
  describe "fundamental" do
    before(:each) do
      @attr = {
        :user_id => 1, 
        :quiz_id => 1, 
      }
    end

    it "ユーザーIDがないと検証NGであること" do
      answer = Answer.new(@attr.merge(:user_id => ""))
      answer.should_not be_valid
    end

    it "クイズIDがないと検証NGであること" do
      answer = Answer.new(@attr.merge(:quiz_id => ""))
      answer.should_not be_valid
    end

    it "ユーザーIDが数字でないと検証NGであること" do
      answer = Answer.new(@attr.merge(:user_id => "a"))
      answer.should_not be_valid
    end

    it "クイズIDが数字でないと検証NGであること" do
      answer = Answer.new(@attr.merge(:quiz_id => "a"))
      answer.should_not be_valid
    end

    it "全て満たしているとき検証OKであること" do
      answer = Answer.new(@attr)
      answer.should be_valid
    end
 
  end
end
