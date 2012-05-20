#encoding:UTF-8
class AnswersController < ApplicationController
  skip_before_filter :authenticate
  def new
  end

  def create
    logger.debug('answers createが通過されているか？')
    data = params[:quiz]
    logger.debug(params[:quiz])
    quiz_id = data["id"]
    user_id = data["user_id"]
    quizzes = Quiz.where(:id => quiz_id)
    quizzes.each {|q| @quiz = q}

    @answer = data["quiz_answer_radio"]

    @clear = false
    if @quiz.quiz_answer_radio.to_s === @answer.to_s then
      @clear = true
      logger.debug('正解か？')
    end

    if @clear
      # 正解の時
      # メダルを増やす
      # Answer.newする
      # TODO:ただし、クイズ出題者にはポイントは加算しない
      @answer = Answer.new({'user_id' => Integer(user_id),'quiz_id' => Integer(quiz_id)})
      if @answer.save
        @user = User.find(@quiz.user_id)
        @user.pointup(3)
        @user.save
        #format.html { redirect_to 'quizzes/'+quiz_id, notice: @quiz.correct_answer_message}
        #format.json { render json: @answer, status: created, location:@answer}
      end
    else
      # TODO:間違いの時
      # エラーメッセージつきで
      # 元の質問にリダイレクトする
      #format.html { redirect_to 'quizzes/'+quiz_id, notice: @quiz.not_correct_answer_message}
    end
  end
end
