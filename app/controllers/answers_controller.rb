class AnswersController < ApplicationController
  def new
  end

  def create
    data = params[:quiz]
    quiz_id = data["id"]
    quizzes = Quiz.where(:id => quiz_id)
    quizzes.each {|q| @quiz = q}

    @answer = data["quiz_answer_radio"]

    @clear = false
    if @quiz.quiz_answer_radio.to_s === @answer.to_s then
      @clear = true
    end

    if @clear
      # TODO:正解の時
      # メダルを増やす
      # Answer.newする
    else
      # TODO:間違いの時
      # エラーメッセージつきで
      # 元の質問にリダイレクトする
    end
    redirect_to '/quizzes/'+quiz_id
  end
end
