require 'rails_helper'

RSpec.describe "the projects enpoints #puts", :type => :request do
	context "when not logged in" do
		it "returns 401 when tring to update a project" do
			project = Project.create(title: "Post Test", description: "description")
			put "/projects/#{project.id}", params: { title: "updated title", description: "updated_description" }
			
			expect(response.status).to eq 401
		end
	end
	
	context "when logged in" do
		before :all do
			@user = User.create(username:"jake", email:"jake@test.com", password:"1234")
			login(@user.id, @user.password)
			
			@project1 = Project.create!(title: "project1", description: "this is a test")
			@project2 = Project.create!(title: "project2", description: "this is another test")
			Subscription.create(project_id: @project1.id, user_id: @user.id, role:"owner")
		end
		
		it "returns 401 if the current user is not the project owner" do
			put_with_auth "/projects/#{@project2.id}", { title: "updated title", description: "updated_description" }
			
			expect(response.status).to eq 401
		end
		
		it "updates a project and returns the project info" do
			put_with_auth "/projects/#{@project1.id}", { title: "updated title", description: "updated_description" }
			
			body = JSON.parse(response.body)
			expect(body["title"]).to eq "updated title"
			expect(body["description"]).to eq "updated_description"
		end
	end
end
