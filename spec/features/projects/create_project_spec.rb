require 'rails_helper'

RSpec.describe 'the projects endpoints #post', :type => :request do
	
	context "when not logged in" do
		it "returns 401 when tring to make a new project" do
			post "/projects", params: { title: "Post Test", description: "description" }
			
			expect(response.status).to eq 401
		end
	end

	context "when logged in" do
		before :all do
			@user = User.create(username:"jake", email:"jake@test.com", password:"1234")
			login(@user.id, @user.password)
		end
		
		it "it responds with a 200 and the new project info" do
			post_with_auth "/projects", { title: "Post Test", description: "description"}
			
			expect(response.status).to eq 200
			@project = JSON.parse(response.body)
			expect(@project["title"]).to eq "Post Test"
			expect(@project["description"]).to eq "description"
		end
		
		it "saves the project to the database" do
			post_with_auth "/projects", { title: "Post Test", description: "description"}
			id = JSON.parse(response.body)['id']
			
			project = Project.find(id)
			expect(project["title"]).to eq "Post Test"
			expect(project["description"]).to eq "description"
		end
		
		it "makes the current user the owner" do
			post_with_auth "/projects", { title: "Post Test", description: "description"}
			id = JSON.parse(response.body)['id']
			
			owner = Project.find(id).subscriptions.find_by(role: "owner").user
			expect(owner).to eq @user
		end
	end
end
