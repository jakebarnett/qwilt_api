require 'rails_helper'
require 'byebug'

RSpec.describe "the sqaures endpoint", :type => :request do
	before :all do
		@project = Project.create!(title: "project1", description: "this is a test")
	end
	
	it "returns a list of square for a given project" do
		get "/projects/#{@project.id}/squares"
				
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body[0]["position"]).to eq 0
		expect(body[99]["position"]).to eq 99
	end
	
	it "returns a specific square " do
		square_id = @project.squares.where(position: 44)[0].id
		
		get "/projects/#{@project.id}/squares/#{square_id}"
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["position"]).to eq 44
		expect(body["usable"]).to eq true
	end
	
	# should we create all squares when the project is created?
	xit "can create a square" do
		post "/projects/#{@project.id}/squares", title: "Test Square", position: 12
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "Test Square"
		expect(body["position"]).to eq 12
	end
	
	it "can update an existing square" do
		square = @project.squares.where(position: 44)[0]

		put "/projects/#{@project.id}/squares/#{square.id}", title: "CHANGED", used: true

		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "CHANGED"
		expect(body["used"]).to eq true
		
		square.reload
		expect(square.title).to eq "CHANGED"
		expect(square.used).to eq true
	end
	
	# users dont need to delete squares
	xit "can delete a square" do
		delete "/projects/#{@project.id}/squares/44"
		
		expect(Square.where(id: square.id).count).to be 0
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["position"]).to eq 44
	end
end
