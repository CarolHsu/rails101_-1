class Admin::BoardsController < ApplicationController
	layout "admin"
	before_filter :require_is_admin


	def index
		@boards = Board.all
	end

	def new
		@board = Board.new
	end

	def edit
		@board = Board.find(params[:id])
	end

	def create
		@board = Board.new(params[:board])

		if @board.save
			redirect_to board_path(@board)
		else
			render :action => "new"
		end
	end

	def update
		@board = Board.find(params[:id])

		if @board.update_attributes(params[:board])
			redirect_to rboard_path(@board)
		else
			render :action => "edit"
		end
	end

	def destroy
		@board = Board.find(params[:id])
		@board.destroy

		redirect_to admin_boards_url
	end
end