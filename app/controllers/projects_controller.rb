class ProjectsController < ApplicationController
	def index
		get_projects
	end
	
	def show
		get_project
	end
	
	def create
		create_project
	end
	
	def update
		update_project
	end
	
	def destroy
		delete_project
	end
	
	private
	
	def get_projects
		projects = Project.all
		render json: projects, status: 200
	end
	
	def get_project
		project = Project.find(params[:id])
		render json: project, status: 200
	end
	
	def create_project
		project = Project.create!(
			title: 				params[:title],
			description: 	params[:description]
			)
		render json: project, status: 200
	end
	
	def update_project
		project = Project.find(params[:id])
		project[:title] = params[:title]
		project[:description] = params[:description]
		project.save
		render json: project, status: 200
	end
	
	def delete_project
		project = Project.find(params[:id])
		project.destroy!
	end
end