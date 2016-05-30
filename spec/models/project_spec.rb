RSpec.describe "the Project model" do
	it "creates 100 child squares after it a new project is created" do
		project = Project.create(title: "Test Project 1", description: "this is a test")
		
		expect(project.squares.count).to eq 100
	end
	
	it "always makes the center square usable" do
		project = Project.create(title: "Test Project 1", description: "this is a test")
		
		expect(project.squares[44].usable).to eq true
		expect(project.squares[45].usable).to eq false
	end
end
