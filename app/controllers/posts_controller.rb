class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_board


  def index
  	redirect_to board_path(@board)
  end

  def show
    @post = @board.posts.find(params[:id])
  end

  def new
    @post = @board.posts.build
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = @board.posts.build(params[:post])
    @post.user_id = current_user.id

    if @post.save
      redirect_to board_post_path(@board, @post)
    else
      render :action => "new"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render :action => "edit"
    end
  end

  def destroy
  	@post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to board_posts_path(@board)
  end

  protected
    def find_board
      @board = Board.find(params[:board_id])
    end
end