json.owner @projects do |project|
	if project.subscriptions.where(user_id: @current_user.id)[0].role == "owner"
		json.id 				project.id
		json.title 				project.title
		json.description 	project.description
		json.created_at 	project.created_at
		json.updated_at 	project.updated_at
	end
end
json.admin @projects do |project|
	if project.subscriptions.where(user_id: @current_user.id)[0].role == "admin"
		json.id 				project.id
		json.title 				project.title
		json.description 	project.description
		json.created_at 	project.created_at
		json.updated_at 	project.updated_at
	end
end
json.collaborator @projects do |project|
	if project.subscriptions.where(user_id: @current_user.id)[0].role == "collaborator"
		json.id 				project.id
		json.title 				project.title
		json.description 	project.description
		json.created_at 	project.created_at
		json.updated_at 	project.updated_at
	end
end
