require 'rails_helper'

RSpec.describe "the users endpoint #create" do
	it "creates a user" do
		post "/users", params:{
			username: "SmokeyJoe",
			email: "smkj@faker.com",
			password: "1234"
		}
		
		expect(response.status).to eq 200
		user = JSON.parse(response.body)
		expect(user["username"]).to eq "SmokeyJoe"
		expect(user["email"]).to eq "smkj@faker.com"
	end
end
