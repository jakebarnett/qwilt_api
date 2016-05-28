require 'rails_helper'

RSpec.describe "the sqaures endpoint", :type => :request do
	it "returns a list of square for a given project" do
		project = Project.create!(title: "project1", description: "this is a test")
		square = project.squares.create!(title: "test1", position: [4,4])
		square2 = project.squares.create!(title: "test2", position: [3,3])
		
		get "/projects/#{project.id}/squares"
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body[0]["title"]).to eq "test1"
		expect(body[0]["position"]).to eq [4,4]
		expect(body[1]["title"]).to eq "test2"
		expect(body[1]["position"][0]).to eq 3
	end
	
	it "returns a specific square " do
		project = Project.create!(title: "project1", description: "this is a test")
		square = project.squares.create!(title: "test1", position: [4,4])
		
		get "/projects/#{project.id}/squares/#{square.id}"
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "test1"
		expect(body["position"]).to eq [4,4]
	end
	
	it "can create a square" do
		project = Project.create!(title: "project1", description: "this is a test")
		post "/projects/#{project.id}/squares", title: "Test Square", position: [1,2]
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "Test Square"
		expect(body["position"]).to eq [1,2]
	end
	
	it "can update an existing square" do
		project = Project.create!(title: "project1", description: "this is a test")
		square = project.squares.create!(title: "test1", position: [4,4])
		expect(square.title).to eq "test1"
		expect(square.position).to eq [4,4]
		
		put "/projects/#{project.id}/squares/#{square.id}", title: "CHANGED", position: [2,3]

		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "CHANGED"
		expect(body["position"]).to eq [2,3]
		
		square.reload
		expect(square.title).to eq "CHANGED"
		expect(square.position).to eq [2,3]
	end
	
	it "can delete a square" do
		project = Project.create!(title: "project1", description: "this is a test")
		square = project.squares.create!(title: "test1", position: [4,4])
		
		delete "/projects/#{project.id}/squares/#{square.id}"
		
		expect(Square.where(id: square.id).count).to be 0
		
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "test1"
		expect(body["position"]).to eq [4,4]
	end
end
