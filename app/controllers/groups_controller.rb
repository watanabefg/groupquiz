# encoding:UTF-8
class GroupsController < ApplicationController
  include ActiveMerchant::Billing

  def new
    @group = Group.new
    @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
  end

  def index
    if params[:cond] === 'owner' then
      @group = Group.where('user_id = ?', params[:user_id])
      @title = "参加中のグループの一覧"
    elsif params[:cond] === 'part' then
      @group = Group.where('id = 0')
      array = []
      i = 0
      belongstogroup = BelongsToGroup.where('user_id = ?', params[:user_id])
      belongstogroup.each do |b|
        array[i] = Group.find(b.group_id)
        i = i + 1
      end
      @group = array
      @title = "参加中のグループの一覧"
    else
      @group = Group.order('created_at desc').limit(20)
      @title = "グループの一覧"
    end
  end

  def ordergroup
    @group = Group.order('title desc').limit(20)
    @title = "グループの一覧"
  end

  def orderowner
    @group = Group.order('user_id desc').limit(20)
    @title = "グループの一覧"
  end

  def orderupdated
    @group = Group.order('created_at desc').limit(20)
    @title = "グループの一覧"
  end

  def create
    @group = Group.new(params[:group])
    group_save = @group.save

    belongs = {
      "user_id" => params[:group]["user_id"],
      "group_id" => @group.id
    }
    @belongstogroup = BelongsToGroup.new(belongs)

    if group_save && @belongstogroup.save then
      flash[:success] = "登録に成功しました"
      redirect_to @group
    else
      @title = "グループの作成|Groupquiz:クイズで楽しく情報共有"
      render 'new'
    end
  end

  def dropin
    @group = Group.find(params[:id])
    if @group.price > 0 then
      @payment = Payment.where(["user_id = ? and group_id = ?", session["user_id"], params[:id]]).first
      if @payment.nil? then
        flash[:error] = "支払いができていないためこのグループへは参加できません。"
        redirect_to @group
        return
      end
    end

    belongs = {
      "user_id" => session["user_id"],
      "group_id" => params[:id]
    }
    @belongstogroup = BelongsToGroup.new(belongs)

    if @belongstogroup.save then
      flash[:success] = "このグループに参加しました"
    else
      flash[:error] = "グループへの参加に失敗しました"
    end
    redirect_to @group
  end

  def show
    @group = Group.find(params[:id])

    belongstogroup = BelongsToGroup.
      where('user_id = ?', session[:user_id]).
      where('group_id = ?', params[:id])

    # 参加しているかどうかのフラグ
    @belongstogroup = false
    belongstogroup.each do |b|
      @belongstogroup = true
    end

    @quizzes = @group.quizzes
    @members = @group.users
    # オーナーユーザー
    @user = User.find(@group.user_id)
    @title = @group.title
  end

  def edit
    @group = Group.find(params[:id])
    @title = "グループの編集|Groupquiz:クイズで楽しく情報共有"
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group]) then
      flash[:success] = "グループ情報を更新しました。"
      redirect_to @group
    else
      @title = "グループの編集|Groupquiz:クイズで楽しく情報共有"
      render 'edit'
    end
  end

  def dropout
    @group = Group.find(params[:id])
    @user = @group.users
    # 関連モデルから削除する
    @belongstogroup = BelongsToGroup.
      where('user_id = ?', params[:group][:user_id]).
      where('group_id = ?', params[:id])
    # 存在していれば削除する
    @belongstogroup.each do |b|
      BelongsToGroup.destroy(@belongstogroup)
      if @group.user_id.to_s === params[:group][:user_id].to_s then
        # グループのオーナーだったら
        # 関連モデルに他のユーザーがいるか確認
        # いなければ削除
        # いれば次のオーナーを決める画面に遷移
        bg = BelongsToGroup.where('group_id = ?', params[:id])

        if bg === [] then
          Group.delete(@group)
        else
          redirect_to edit_group_path(@group) and return
        end
      end
      flash[:success] = "このグループから抜けました。"
      redirect_to :action => 'index' and return
    end
    flash[:success] = "このグループには入っていません。"
    redirect_to :action => 'index'
  end

  def checkout
    session[:group_id] = params[:id]
    @group = Group.find(params[:id])
    # 100 * するのは、日本円対応のため
    setup_response = gateway.setup_purchase(100 * @group.price,
      :ip                 => request.remote_ip,
      :return_url         => url_for(:controller => 'groups', :action => 'confirm', :only_path => false),
      :cancel_return_url  => url_for(:controller => 'groups', :action => 'index', :only_path => false)
    )
    redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    redirect_to :action => 'index' unless params[:token]

    details_response = gateway.details_for(params[:token])

    if !details_response.success?
      @message = details_response.message
      @title = 'エラーが発生しました'
      render :action => 'error'
      return
    end
    @title = "ご請求内容の確認"
    @group = Group.find(session[:group_id])

    @address = details_response.address
  end

  def complete
    group = Group.find(session[:group_id])
    # 100 * するのは、日本円対応のため
    purchase = gateway.purchase(100 * group.price,
                                :ip => request.remote_ip,
                                :payer_id => params[:payer_id],
                                :token => params[:token]
                               )
    if !purchase.success?
      @message = purchase.message
      @title = 'エラーが発生しました'
      render :action => 'error'
      return
    end
    @title = "お支払い完了"
    # NOTE:サンキュー画面にリンクを張ってしまうと、
    # リンクのクリック忘れのときに手間が発生するので
    # 支払い管理と所属には自動的に登録する
    data = {
      "user_id" => session["user_id"],
      "group_id" => session[:group_id],
      "shiharaikbn" => 1,
    }
    @payment = Payment.new(data)
    if !@payment.save then
      @message = "支払い登録に失敗しました。管理者に連絡してください。"
      @title = 'エラーが発生しました'
      render :action => 'error'
      return
    end

    # TODO:dropinの内容をコピーしてきたので、後で共通メソッドを作る
    belongstogroup = {
      "user_id" => session["user_id"],
      "group_id" => session[:group_id]
    }
    @belongstogroup = BelongsToGroup.new(belongstogroup)

    if @belongstogroup.save then
      flash[:success] = "このグループに参加しました"
    else
      flash[:error] = "グループへの参加に失敗しました。管理者に連絡してください。"
    end
  end

  private
  def gateway
    @gateway ||= PaypalExpressGateway.new(
      :login => 'sheo30_1338283608_biz_api1.hotmail.co.jp',
      :password => '1338283627',
      :signature => 'ADooGyqEq0Wdvmbp8Y80f0bEvtI5ANpCwblvOqMxUKYCmJOs2TFsDz-p'
    )
  end

end
