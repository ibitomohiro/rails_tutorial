class UsersController < ApplicationController
 def show
  @user = User.find(params[:id])
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
      #Success (valid params)
    else
      # failure(not valid params)
      render 'new' #もう一回newに戻る
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
