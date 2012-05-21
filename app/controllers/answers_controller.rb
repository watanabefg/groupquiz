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
      # メダルを増やし、Answer.newする
      # ただし、クイズ出題者にはポイントは加算しない
      @answer = Answer.new({'user_id' => Integer(user_id),'quiz_id' => Integer(quiz_id)})
      if @answer.save then
        if user_id.to_s != @quiz.user_id.to_s then
          @user = User.find(@quiz.user_id)
          @user.pointup(3)
          @user.save
        end
        flash[:notice] = @quiz.correct_answer_message
        respond_to do |format|
          format.html { redirect_to :controller => 'quizzes',:action => 'show', :id => quiz_id }
          #format.json { render json: @answer, status: created, location:@answer}
        end
      end
    else
      # 間違いの時
      # 間違いのメッセージつきで元の質問にリダイレクトする
      flash[:warning] = @quiz.not_correct_answer_message
      respond_to do |format|
        format.html { redirect_to :controller => 'quizzes',:action => 'show', :id => quiz_id }
      end
    end
  end
end
