class UsersController < ApplicationController
	def create
		create_user
	end
	
	private
	
	def create_user
		user = User.create!(
			username: params[:username],
			email: params[:email],
			password: params[:password],
		)
		render json: user, status: 200
	end

end
