class PostsController < ApplicationController

  before_action :require_login

  def new
    @post = Post.new
  end


  def show
    @post = Post.find_by(id: params[:id])
  end

  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@sub)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @sub = Sub.find_by(id: params[:sub_id])
    @post.sub_id = @sub.id
    if @post.save
      redirect_to sub_url(@sub)
    else
      flash[:error] = ["error creating post"]
      render :new
    end
  end

  def edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.update_attributes(post_params)
      redirect_to sub_url(@sub)
    else
      flash[:error] = ["error updating post"]
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end
end
