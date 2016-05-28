require 'byebug'

class SquaresController < ApplicationController
	
	def index
		get_project_squares
	end
	
	def show
		get_square
	end
	
	def create
		new_square
	end
	
	def update
		update_square
	end
	
	def destroy
		delete_square
	end
	
	
	private
	
	def get_project_squares
		squares = Project.find(params[:project_id]).squares
		render json: squares, status: 200
	end
	
	def get_square
		square = Project.find(params[:project_id]).squares.find(params[:id])
		render json: square, status: 200
	end
	
	def new_square
		square = Project.find(params[:project_id]).squares.create!(
			title: params[:title],
			position: params[:position]
		)
		render json: square, status: 200
	end
	
	def update_square
		square = Project.find(params[:project_id]).squares.find(params[:id])
		square.title = params[:title]
		square.position = params[:position]
		square.save
		render json: square, status: 200
	end
	
	def delete_square
		square = Project.find(params[:project_id]).squares.find(params[:id])
		square.destroy!
		render json: square, status: 200
	end
end
