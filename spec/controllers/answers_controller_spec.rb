#encoding:UTF-8
require 'spec_helper'

describe AnswersController do

  describe "POST 'create'" do
    describe "登録させないケースの検証" do 
      before(:each) do 
        @attr = {:user_id => 1, :quiz_id => 1, :quiz_answer_radio => "" } 
      end 
      it "答えを登録しないこと" do 
        lambda do 
          post :create, :answer => @attr
        end.should_not change(Answer, :count)
      end 

      it "新規登録ページに戻ること(タイトル検証)" do 
        post :create, :answer => @attr
        response.should have_selector("title", :content => "グループの作成|Groupquiz:クイズで楽しく情報共有") 
      end 
     # it "新規登録ページに戻ること(テンプレート検証)" do 
     #   post :create,  :group => @attr
     #   response.should render_template('new') 
     # end 
    end #登録させないケースの検証 
  end

end
