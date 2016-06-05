require 'rails_helper'

RSpec.describe 'the projects endpoints #get', :type => :request do
	context "when logged in" do
		before :all do
			@user = User.create(username:"jake", email:"jake@test.com", password:"1234")
			login(@user.id, @user.password)
			
			@project1 = Project.create!(title: "project1", description: "this is a test")
			@project2 = Project.create!(title: "project2", description: "this is another test")
			@project3 = Project.create!(title: "project3", description: "test user is not subscribed")
			
			@project1.users << @user
			@project2.users << @user
		end
		
		it "lists all projects for the current user" do
			get_with_auth '/projects'
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body[1]["title"]).to eq "project1"
			expect(body[1]["description"]).to eq "this is a test"
			expect(body[0]["title"]).to eq "project2"
			expect(body[0]["description"]).to eq "this is another test"
		end
		
		it "doesn't list projects where current user is not subscribed" do
			get_with_auth '/projects'
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body.map { |p| p["title"] }).to_not include("project3")
		end
		
		it "lists a specific project" do
			get_with_auth "/projects/#{@project1.id}"
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body["title"]).to eq "project1"
			expect(body["description"]).to eq "this is a test"
		end
		
		it "returns 401 for a project the current user is not subscribed to" do
			get_with_auth "/projects/#{@project3.id}"
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 401
			expect(response.body).to eq '{"error":"unauthorized"}'
		end
	end
end
