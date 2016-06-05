class SquaresController < ApplicationController
	before_action :authenticate_request!
	
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
	
	# def destroy
	# 	delete_square
	# end
	
	
	private
	
	def get_project_squares
		if check_subscription
			squares = Project.find(params[:project_id]).squares.order(position: :asc)
			render json: squares, status: 200
		else
			render json: { error: "unauthorized" }, status: 401
		end
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
		if ["admin", "owner"].include? check_subscription
			square = Project.find(params[:project_id]).squares.find(params[:id])
			square.title = params[:title] if params[:title]
			square.used = params[:used] if params[:used]
			square.save
			render json: square, status: 200
		else
			render json: { error: "unauthorized" }, status: 401
		end
	end
	
	# for now, we don't want users to delete a square.
	# def delete_square
	# 	square = Project.find(params[:project_id]).squares.find(params[:id])
	# 	square.destroy!
	# 	render json: square, status: 200
	# end
	
	def check_subscription
		project = Project.find(params[:project_id])
		sub = project.subscriptions.find_by(user_id: current_user.id)
		return sub[:role] if sub
		false
	end
end
