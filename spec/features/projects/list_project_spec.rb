require 'rails_helper'

RSpec.describe 'the projects endpoints:', :type => :request do
	it "get /projects list all projects" do
		Project.create!(title: "project1", description: "this is a test")
		Project.create!(title: "project2", description: "this is another test")
		
		get '/projects'
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body[1]["title"]).to eq "project1"
		expect(body[1]["description"]).to eq "this is a test"
		expect(body[0]["title"]).to eq "project2"
		expect(body[0]["description"]).to eq "this is another test"
	end
	
	it "get /projects/:id lists a specific project" do
		project = Project.create!(title: "project1", description: "this is a test")
		
		get "/projects/#{project.id}"
		body = JSON.parse(response.body)
		expect(response.status).to eq 200
		expect(body["title"]).to eq "project1"
		expect(body["description"]).to eq "this is a test"
	end
	
	it "post /project creates a new project" do
		post "/projects", title: "Post Test", description: "description"
		expect(response.status).to eq 200
		
		id = JSON.parse(response.body)["id"]
		get "/projects/#{id}"
		body = JSON.parse(response.body)
		expect(body["title"]).to eq "Post Test"
		expect(body["description"]).to eq "description"
	end
	
	it "puts /project/:id updates a project" do
		post "/projects", title: "Post Test", description: "description"
		id = JSON.parse(response.body)["id"]
		put "/projects/#{id}", title: "updated title", description: "updated_description"
		body = JSON.parse(response.body)
		expect(body["title"]).to eq "updated title"
		expect(body["description"]).to eq "updated_description"
	end
	
end
