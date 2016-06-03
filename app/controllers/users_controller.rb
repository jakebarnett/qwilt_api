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
	end

end
