require_relative "../lib/kickstarter.rb"

describe "Project" do
  it "has title" do
    project = Project.create({title: "Test", goal: 1000})
    expect(project.title).to eq("Test")
    expect(project.goal).to eq(1000)
  end
end

describe "Data Model should" do
  it "have projects that have pledges and users" do
    project = Project.create(title: "Test", goal: 2000)
    user = User.create(name: "Dave")

    project.pledges.create(amount: 1000, user_id: user.id)
    expect(project.pledges.count).to eq(1)
    expect(project.pledges.first.amount).to eq(1000)
  end

  it "projects can have multiple pledges" do
    project = Project.create(title: "Test", goal: 2000)
    user = User.create(name: "Dave")

    project.pledges.create(amount: 1000, user_id: user.id)
    project.pledges.create(amount: 1000, user_id: user.id)
    project.pledges.create(amount: 1000, user_id: user.id)

    expect(project.pledges.count).to eq(3)
  end
end
