class UsersController < ApplicationController


  def new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      #redirect_to somewhere
    else
      flash[:errors] = ["login error"]
      render :new
    end
  end



  def user_params
    params.require(:user).permit(:username, :password)
  end
end
