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
    groups = Group.where(:id => @quiz.group_id)
    groups.each {|g| @group = g}
    group_category = @group.group_category_radio

    if group_category.to_s == '1' then
      @clear = false
      # 登録されているデータと送信データを比較して、合っていたら正解
      if @quiz.quiz_answer_radio.to_s === @answer.to_s then
        @clear = true
      end

      if @clear
        # 正解の時
        # 一度回答した人には正解のメッセージを出すだけにする
        # クイズ出題者にはポイントは加算しない
        #
        # 初めて回答した人には
        # メダルを増やし、Answer.newする
        answerLog = Answer.where(:quiz_id => quiz_id)
        answerLog.each {|l| @log = l}
        logger.debug(answerLog)

        if @log || user_id.to_s == @quiz.user_id.to_s then
          flash[:notice] = @quiz.correct_answer_message
          respond_to do |format|
            format.html { redirect_to :controller => 'quizzes',:action => 'show', :id => quiz_id }
            #format.json { render json: @answer, status: created, location:@answer}
          end
        else
          @answer = Answer.new({'user_id' => Integer(user_id),'quiz_id' => Integer(quiz_id)})
          if @answer.save then
            @user = User.find(@quiz.user_id)
            @user.pointup(3)
            @user.save
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
    else
      # 2番めのパターン診断は間違いが存在しない
      answerLog = Answer.where(:quiz_id => quiz_id)
      answerLog.each {|l| @log = l}
      logger.debug('答えのラジオボタンはこれ')
      logger.debug(@answer)

      # 一度回答した人には正解のメッセージを出すだけにする
      # クイズ出題者にはポイントは加算しない
      #
      # 初めて回答した人には
      # メダルを増やし、Answer.newする
      if @log || user_id.to_s == @quiz.user_id.to_s then
        case @answer.to_s
        when '1'
          flash[:notice] = @quiz.correct_answer_message
          logger.debug('これは？')
        when '2'
          flash[:notice] = @quiz.correct_answer_message2
        when '3'
          flash[:notice] = @quiz.correct_answer_message3
        when '4'
          flash[:notice] = @quiz.correct_answer_message4
        end
        respond_to do |format|
          format.html { redirect_to :controller => 'quizzes',:action => 'show', :id => quiz_id }
          #format.json { render json: @answer, status: created, location:@answer}
        end
      else
        @answer = Answer.new({'user_id' => Integer(user_id),'quiz_id' => Integer(quiz_id)})
        if @answer.save then
          @user = User.find(@quiz.user_id)
          @user.pointup(3)
          @user.save
        end
      end
    end
  end

end
