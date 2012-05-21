#encoding:UTF-8
class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzes }
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
    @category = Category.find(@quiz.category_id)
    @user = User.find(@quiz.user_id)
    @category_name = @category.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quiz }
    end
  end

  def new
    respond_to do |format|
      if params[:gid]
        @group_id = params[:gid]
      else
        flash[:notice] = '先にクイズを公開するグループを選んでください'
        format.html { redirect_to :controller => 'groups', :action => 'index' }
      end
      @quiz = Quiz.new
      @categories = Category.find(:all)

      format.html # new.html.erb
      format.json { render json: @quiz }
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @categories = Category.find(:all)
  end

  def create
    @quiz = Quiz.new(params[:quiz])
    logger.debug(params[:quiz])

    respond_to do |format|
      if @quiz.save
        # TODO:登録したユーザーに5ポイントあげる
        @user = User.find(@quiz.user_id)
        @user.pointup(5)
        @user.save

        format.html { redirect_to @quiz, notice: 'クイズが作成されました! 5枚メダルが追加されました!' }
        format.json { render json: @quiz, status: :created, location: @quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz[:user_id] == session[:user_id] then
      respond_to do |format|
        if @quiz.update_attributes(params[:quiz])
          format.html { redirect_to @quiz, notice: 'クイズが更新されました!' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @quiz.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to quizzes_url, notice: "あなたはこのクイズを編集することはできません。" }
      end
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])

    if @quiz[:user_id] == session[:user_id] then
      @quiz.destroy
      respond_to do |format|
        format.html { redirect_to quizzes_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to quizzes_url, notice: "あなたはこのクイズを削除することはできません。" }
      end
    end
  end
end
