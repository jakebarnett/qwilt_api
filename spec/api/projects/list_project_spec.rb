require 'rails_helper'

RSpec.describe 'the projects endpoints #get', :type => :request do
	context "when logged in" do
		before :all do
			@user = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user.username, @user.password)
			
			@project1 = Project.create!(title: "project1", description: "this is a test")
			@project2 = Project.create!(title: "project2", description: "this is another test")
			@project3 = Project.create!(title: "project3", description: "and another")
			@project4 = Project.create!(title: "project3", description: "test user is not subscribed")
			
			Subscription.create(project_id: @project1.id, user_id: @user.id, role:"owner")
			Subscription.create(project_id: @project2.id, user_id: @user.id, role:"admin")
			Subscription.create(project_id: @project3.id, user_id: @user.id, role:"collaborator")
		end
		
		it "lists all projects for the current user" do
			get_with_auth '/projects'
			
			projects = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(projects["owner"].size).to be 1
			expect(projects["owner"][0]["id"]).to be @project1.id
			expect(projects["admin"].size).to be 1
			expect(projects["admin"][0]["id"]).to eq @project2.id
			expect(projects["collaborator"].size).to be 1
			expect(projects["collaborator"][0]["id"]).to eq @project3.id
		end
		
		it "doesn't list projects where current user is not subscribed" do
			get_with_auth '/projects'
			
			projects = JSON.parse(response.body)
			projects = projects["collaborator"] << projects["admin"] << projects["owner"]
			projects = projects.flatten.map { |p| p["title"] }
			expect(response.status).to eq 200
			expect(projects).to_not include("project4")
		end
		
		it "lists a specific project" do
			get_with_auth "/projects/#{@project1.id}"
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body["title"]).to eq "project1"
			expect(body["description"]).to eq "this is a test"
		end
		
		it "returns 401 for a project the current user is not subscribed to" do
			get_with_auth "/projects/#{@project4.id}"
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 401
			expect(response.body).to eq '{"error":"unauthorized"}'
		end
	end
end
