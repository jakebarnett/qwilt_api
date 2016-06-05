require 'rails_helper'

RSpec.describe "the sqaures endpoint get", :type => :request do
	before :all do
		@project1 = Project.create!(title: "project1", description: "this is a test")
		@project2 = Project.create!(title: "project1", description: "this is a test")
	end
	
	context "when not logged in" do
		it "returns 401 when tring to get squares" do
			get "/projects/#{@project1.id}/squares"
			
			expect(response.status).to eq 401
		end
	end
	
	context "when logged in" do
		before :all do
			@user = User.create(username:Faker::Internet.user_name, email:"jake@test.com", password:"1234")
			login(@user.username, @user.password)
			@project1.users << @user
		end
		
		it "returns a list of squares if current_user is subscribed to the project" do
			get_with_auth "/projects/#{@project1.id}/squares"
					
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body[0]["position"]).to eq 0
			expect(body[99]["position"]).to eq 99
		end
		
		it "returns a 401 if current_user is not subscribed to the project" do
			get_with_auth "/projects/#{@project2.id}/squares"
			
			expect(response.status).to eq 401
		end
		
		it "returns a specific square " do
			square_id = @project1.squares.where(position: 44)[0].id
			
			get_with_auth "/projects/#{@project1.id}/squares/#{square_id}"
			
			body = JSON.parse(response.body)
			expect(response.status).to eq 200
			expect(body["position"]).to eq 44
			expect(body["usable"]).to eq true
		end
	end
end
