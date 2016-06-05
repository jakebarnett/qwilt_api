require 'rails_helper'

RSpec.describe "the Project model" do
	before(:all) do
		@project = Project.create(title: "Test Project 1", description: "this is a test")
	end
	
	it "creates 100 child squares after it a new project is created" do
		expect(@project.squares.count).to eq 100
	end
	
	it "always makes the center square usable" do
		expect(@project.squares.order(position: :asc)[44].usable).to eq true
		expect(@project.squares.order(position: :asc)[45].usable).to eq false
	end
end
