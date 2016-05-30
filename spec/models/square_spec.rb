RSpec.describe "the Square model" do
	before :all do
		@project = Project.create!(title: "project1", description: "this is a test")
	end
	
	it "updates adjacent squares when the `used` field gets updated" do
		square 	= @project.squares.where(position: 33)[0]
		top 		= @project.squares.where(position: square.position + 10)[0]
		bottom	= @project.squares.where(position: square.position - 10)[0]
		left 		= @project.squares.where(position: square.position - 1)[0]
		right 	= @project.squares.where(position: square.position + 1)[0]
		
		expect(square.used).to eq(false)
		expect(top.usable).to eq(false)
		expect(bottom.usable).to eq(false)
		expect(left.usable).to eq(false)
		expect(right.usable).to eq(false)
		
		square.used = true
		square.save!
		
		expect(square.used).to eq(true)
		expect(top.reload.usable).to eq(true)
		expect(bottom.reload.usable).to eq(true)
		expect(left.reload.usable).to eq(true)
		expect(right.reload.usable).to eq(true)
	end
	
	it "does not update the adjacent square when on an edge" do
		square 	= @project.squares.where(position: 20)[0]
		top 		= @project.squares.where(position: square.position + 10)[0]
		bottom	= @project.squares.where(position: square.position - 10)[0]
		left 		= @project.squares.where(position: square.position - 1)[0]
		right 	= @project.squares.where(position: square.position + 1)[0]
		
		expect(square.used).to eq(false)
		expect(top.usable).to eq(false)
		expect(bottom.usable).to eq(false)
		expect(left.usable).to eq(false)
		expect(right.usable).to eq(false)
		
		square.used = true
		square.save!
		
		expect(square.used).to eq(true)
		expect(top.reload.usable).to eq(true)
		expect(bottom.reload.usable).to eq(true)
		expect(left.reload.usable).to eq(false)
		expect(right.reload.usable).to eq(true)
	end
end
