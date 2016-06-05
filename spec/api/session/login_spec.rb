require 'rails_helper'

RSpec.describe "the auth endpoint" do
	before :all do
		@user = User.create(username: "SessionTester", email:"st@faker.com", password:"123321")
	end
	
	context "with a valid password and username" do
		it "it returns a token" do
			post "/authenticate", params: { username: "SessionTester", password:"123321" }

			expect(response.status).to eq 200
			payload = JSON.parse(response.body)
			expect(payload['auth_token']).to_not be nil
			decoded = AuthToken.decode(payload['auth_token'])
			expect(decoded["user_id"]).to eq @user.id
		end
	end
end
