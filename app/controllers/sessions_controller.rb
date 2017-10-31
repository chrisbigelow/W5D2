class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      #redirect_to somewhere
    else
      flash[:errors] = ["login error"]
      render :new
    end
  end

  def destroy
    logout
    #redirect_to somewhere
  end
end
