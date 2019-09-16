require_relative "../lib/kickstarter.rb"

describe "Project" do
	it "has title" do
		project = Project.create({title: "Test", goal: 1000})
		expect(project.title).to eq("Test")
		expect(project.goal).to eq(1000)
	end 
end
