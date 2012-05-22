class AnswersController < ApplicationController
  def new
  end

  def create
    # logをはく
    logger.debug("hoge")

    data = params[:quiz]
    quiz_id = data["id"]
    quizzes = Quiz.where(:id => quiz_id)
    quizzes.each {|q| @quiz = q}

    @answer = data["quiz_answer_radio"]

    @clear = false
    # 登録されているデータと送信データを比較して、合っていたら正解
    if @quiz.quiz_answer_radio.to_s === @answer.to_s then
      @clear = true
    end

    if @clear
      # TODO:正解の時
      if @answer.save
      # 正解者のメダルを増やす
        @user = User.find(data["user_id"])
        @user.pointup(5)
      end
    else
      # TODO:間違いの時
      # エラーメッセージつきで
      # 元の質問にリダイレクトする
    end
    redirect_to '/quizzes/'+quiz_id
  end
end
