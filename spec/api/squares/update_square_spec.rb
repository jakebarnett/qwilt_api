require 'rails_helper'

RSpec.describe "the square endpoint #put:", :type => :request do
	before :all do
		@project1 = Project.create!(title: "project1", description: "this is a test")
		@project2 = Project.create!(title: "project1", description: "this is a test")
	end
	
	context "when not logged in" do
		it "returns 401 when tring to get squares" do
			put "/projects/#{@project1.id}/squares/#{@project1.squares.first.id}"
			
			expect(response.status).to eq 401
		end
	end
	
	context "when logged in" do
		it "if the current user is an admin, it can update an existing square" do
			@user1 = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user1.username, @user1.password)
			Subscription.create(project_id: @project1.id, user_id: @user1.id, role: "admin")

			square = @project1.squares.where(position: 44)[0]
			put_with_auth "/projects/#{@project1.id}/squares/#{square.id}", title: "CHANGED", used: true

			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body["title"]).to eq "CHANGED"
			expect(body["used"]).to eq true
			square.reload
			expect(square.title).to eq "CHANGED"
			expect(square.used).to eq true
		end
		
		it "if the current user is the owner, it can update an existing square" do
			@user2 = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user2.username, @user2.password)
			Subscription.create(project_id: @project1.id, user_id: @user2.id, role: "owner")

			square = @project1.squares.where(position: 44)[0]
			put_with_auth "/projects/#{@project1.id}/squares/#{square.id}", title: "CHANGED", used: true

			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body["title"]).to eq "CHANGED"
			expect(body["used"]).to eq true
			square.reload
			expect(square.title).to eq "CHANGED"
			expect(square.used).to eq true
		end
		
		it "if the current user is a collaborator, it can not update an existing square" do
			@user3 = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user3.username, @user3.password)
			Subscription.create(project_id: @project1.id, user_id: @user3.id, role: "collaborator")

			square = @project1.squares.where(position: 44)[0]
			put_with_auth "/projects/#{@project1.id}/squares/#{square.id}", title: "CHANGED", used: true

			body = JSON.parse(response.body)
			expect(response.status).to eq 401
		end
	end
end
