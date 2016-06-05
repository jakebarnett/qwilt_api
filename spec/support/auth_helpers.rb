require 'byebug'

module AuthHelpers
	def login(id, password)
		post '/authenticate', params: { id:"#{id}", password:"#{password}" }
		body = JSON.parse(response.body)
		@token = body["auth_token"]
	end
	
	def get_with_auth (path, params=nil)
		get path, params: params, headers: { Authorization: "Bearer #{@token}" }
	end
	
	def post_with_auth (path, params=nil)
		post path, params: params, headers: { Authorization: "Bearer #{@token}" }
	end
	
	def put_with_auth (path, params=nil)
		put path, params: params, headers: { Authorization: "Bearer #{@token}" }
	end
	
	def delete_with_auth(path, params=nil)
		delete path, params: params, headers: { Authorization: "Bearer #{@token}" }
	end
end
