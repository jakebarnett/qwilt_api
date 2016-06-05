class ProjectsController < ApplicationController
	before_action :authenticate_request!
	
	def index
		get_projects
	end
	
	def show
		get_project
	end
	
	def create
		create_project
		assign_owner
	end
	
	def update
		update_project
	end
	
	def destroy
		delete_project
	end
	
	private
	
	def get_projects
		@projects = @current_user.projects.order(created_at: :desc)
		render status: 200
	end
	
	def get_project
		project = Project.find(params[:id])
		if project.users.include?(@current_user)
			render json: project, status: 200
		else
			render json: { error: "unauthorized" }, status: 401
		end
	end
	
	def create_project
		@project = Project.create!(
			title: 				params[:title],
			description: 	params[:description]
			)
		render json: @project, status: 200
	end
	
	def assign_owner
		Subscription.create(
			project_id: @project.id,
			user_id: @current_user.id,
			role: "owner"
		)
	end
	
	def check_owner
		project = Project.find(params[:id])
		sub = project.subscriptions.find_by(user_id: current_user.id)
		return true if sub && sub[:role] == "owner"
		return false
	end
	
	def update_project
		if check_owner
			project = Project.find(params[:id])
			project[:title] = params[:title]
			project[:description] = params[:description]
			project.save
			render json: project, status: 200
		else
			render json: { error: "unauthorized" }, status: 401
		end
	end
	
	def delete_project
		if check_owner
			project = Project.find(params[:id])
			project.destroy!
			render json: project, status: 200
		else
			render json: { error: "unauthorized" }, status: 401
		end
	end
end
