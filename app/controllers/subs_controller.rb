class SubsController < ApplicationController

  before_action :require_login

  def new
  end


  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def update
    sub = current_user.subs.find_by(id: params[:id])
    if sub && sub.update_attributes(sub_params)
      redirect_to sub_url(sub)
    else
      flash[:errors] = ["error updating sub"]
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
