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
        @group = Group.find(@group_id)
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

  def create
    @quiz = Quiz.new(params[:quiz])
    logger.debug(params[:quiz])

    respond_to do |format|
      if @quiz.save
        @user = User.find(@quiz.user_id)
        @user.pointup(5)
        if @user.save
          group = Group.find(@quiz.group_id)
          message = '[' + group.title + ']に新しいクイズが作成されました。「'+ @quiz.quiz_title + '」 http://test.com/quizzes/' + @quiz.id.to_s
          self.tweet(message)

          format.html { redirect_to @quiz, notice: 'クイズが作成されました! 5枚メダルが追加されました!' }
          format.json { render json: @quiz, status: :created, location: @quiz }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end


  def import
    @categories = Category.find(:all)
    if params[:gid]
      group_id = params[:gid]
      session[:gid] = group_id
      @group = Group.find(group_id)
    end
  end

  def upload
    upload = params[:upload][:csv]
    save_file(upload)
  end

  def save_file(upload)
    require 'csv'
    filename = upload.original_filename
    filedir = 'public/upload/'
    File.open(File.join(filedir,filename),'wb'){ |f| f.write(upload.read)}

    login_user_id = session[:user_id]
    group_id = session[:gid]

    # TODO:CSVを読み込んで,カテゴリーIDがなかったら
    # insertしないようにする
    CSV.foreach(File.join(filedir,filename)) do |row|
      data = Quiz.build_from_csv(row,login_user_id, group_id)
      @quiz = Quiz.new(data)
      if @quiz.valid?
        @quiz.save
      else
        errs << row
      end
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @categories = Category.find(:all)
  end

  def tweet(message)
    oauth = Rubytter::OAuth.new('tgcpAoCHiXlLsAakh0vzNA', 'U4bLWFvPQnpUhLzVpLQiA1l7L6ZF7Ksd75uHfx9Q')
    access_token = OAuth::AccessToken.new(oauth.create_consumer, '5903212-hoogD4kEQmaQNTYX5ETFi4ijtbGMz4x8KMRyfOI7k', 'i8fLZpdJYr4cPE01pIZawGNYYB3rtS9TfubndMdpeE')
    rubytter = OAuthRubytter.new(access_token)
    rubytter.update(message)
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
