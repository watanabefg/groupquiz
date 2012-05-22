#encoding:UTF-8
class AnswersController < ApplicationController
  skip_before_filter :authenticate
  def new
  end

  def create
<<<<<<< HEAD
    # logをはく
    logger.debug("hoge")

=======
    logger.debug('answers createが通過されているか？')
>>>>>>> 531a736d8c5f0225c56e4b4e850a503814c9b7b8
    data = params[:quiz]
    logger.debug(params[:quiz])
    quiz_id = data["id"]
    user_id = data["user_id"]
    quizzes = Quiz.where(:id => quiz_id)
    quizzes.each {|q| @quiz = q}

    @answer = data["quiz_answer_radio"]

    @clear = false
    # 登録されているデータと送信データを比較して、合っていたら正解
    if @quiz.quiz_answer_radio.to_s === @answer.to_s then
      @clear = true
      logger.debug('正解か？')
    end

    if @clear
<<<<<<< HEAD
      # TODO:正解の時
      if @answer.save
      # 正解者のメダルを増やす
        @user = User.find(data["user_id"])
        @user.pointup(5)
=======
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
>>>>>>> 531a736d8c5f0225c56e4b4e850a503814c9b7b8
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
