class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = Post.all.order(id: :desc).page(params[:page])
    end
  end

end