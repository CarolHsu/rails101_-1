class Admin::PostsController < ApplicationController
  layout "admin"
  before_filter :require_is_admin
  before_filter :authenticate_user!, :except => [:index]
  before_filter :find_board_post


  def edit
   
  end

  def update

    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render action: "edit"
    end
  end

  def destroy
    @post.destroy

    redirect_to board_posts_path(@board)
  end

  protected
    def find_board_post
      @board = Board.find(params[:board_id])
      @post = @board.posts.find(params[:id])
    end
end