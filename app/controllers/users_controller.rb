class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
    # Get /users
  def index 
    @users = User.paginate(page:params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
 
  def new
    @user = User.new
  end
  #POST users params 
  def create
    # (@user + given params).save
    # User.create(params[:user])
    # => name, email, pass/confirmation
   @user = User.new(user_params) 
   if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      #Success (valid params)
    else
      # failure(not valid params)
      render 'new' #もう一回newに戻る
    end
  end
  # GET /users/(:id)/edit  paramsを記入忘れない
  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
