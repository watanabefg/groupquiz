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
    @category_name = @category.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quiz }
    end
  end

#  def show
#    @quizzes = Quiz.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @quizzes }
#    end
#  end


  def new
    if params[:gid] then
      @group_id = params[:gid]
    end
    @quiz = Quiz.new
    @categories = Category.find(:all)

    respond_to do |format|
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

    respond_to do |format|
      if @quiz.save
        # TODO:登録したユーザーに5ポイントあげる
        @user = User.find(@quiz.user_id)
        @user.pointup(5)

        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render json: @quiz, status: :created, location: @quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to quizzes_url }
      format.json { head :no_content }
    end
  end
end
