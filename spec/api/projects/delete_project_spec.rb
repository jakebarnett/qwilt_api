require 'rails_helper'

RSpec.describe "the projects enpoints #delete", :type => :request do
	context "when not logged in" do
		it "returns 401 when tring to update a project" do
			project = Project.create(title: "Post Test", description: "description")
			delete "/projects/#{project.id}"
			
			expect(response.status).to eq 401
		end
	end
	
	context "when logged in" do
		before :all do
			@user = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user.username, @user.password)
	
			@project1 = Project.create!(title: "project1", description: "this is a test")
			@project2 = Project.create!(title: "project2", description: "this is another test")
			Subscription.create(project_id: @project1.id, user_id: @user.id, role:"owner")
		end
	
		it "returns 401 if the current user is not the project owner" do
			delete_with_auth "/projects/#{@project2.id}", { title: "updated title", description: "updated_description" }
	
			expect(response.status).to eq 401
		end
	
		it "deletes a project if the current user is the owner" do
			expect{
				delete_with_auth "/projects/#{@project1.id}"
			}.to change{ Project.count }.by(-1)
		end
	end
end
