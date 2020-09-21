class SessionsController < ApplicationController
  def new
    # ☓ @session = Session.new
    # ○ scope: :session + url: login_path
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # nilかどうかをチェックするとfind_byする
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      # エラーメッセージを作成する
      # alert-danger 赤色のフラッシュ 
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
      #redirect と renderの違い
      # GET /users/1 => show template
                        #render 'new' 0回
    end
  end

  def destroy
  end
end