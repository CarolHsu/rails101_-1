class PostsController < ApplicationController

	def index
		@board = Board.find(params[:board_id])
		redirect_to board_path(@board)
	end

	def show
		@board = Board.find(params[:board_id])
		@post = @board.posts.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json {render json: @post}
		end
	end

	def new
		@board = Board.find(params[:board_id])
		@post = @board.posts.build

		respond_to do |format|
			format.html # new.html.erb
			format.json {render json: @post}
		end
	end

	def edit
		@board = Board.find(params[:board_id])
		@post = @board.posts.find(params[:id])
	end

	def create
		@board = Board.find(params[:board_id])
		@post = @board.posts.build(params[:post])

		respond_to do |format|
			if @post.save
				format.html {redirect_to board_post_path(@board, @post), notice: 'Post was successfully created!'}
				format.json {render json: @post, status: :created, location: @post}
			else
				format.html {render action: 'new'}
				format.json {render json: @post.error, status: :unprocessable_entity}
			end
		end
	end

	def update
		@board = Board.find(params[:board_id])
		@post = @board.posts.find(params[:id])

		respond_to do |format|
			if @post.update_attributes(params[:post])
				format.html {redirect_to board_post_path(@board, @post), notice: 'Post was successfully updated!'}
				format.json {render @post, status: :updated, location: @post}
			else
				format.html {render action: 'edit'}
				format.json {render json: @post.error, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		@board = Board.find(params[:board_id])
		@post = @board.posts.find(params[:id])
		@post.destroy

		respond_to do |format|
			format.html {redirect_to board_posts_path(@board, @post)}
			format.json {render head :ok}
		end
	end
end
