require 'faker'

10.times do
	Project.create!(
		title: Faker::Company.name,
		description: Faker::Hacker.say_something_smart
	)
end

jake = User.create(username:"jake", email: "jake@fake.com", password: "1234")
pat = User.create(username:"pat", email: "pat@fake.com", password: "1234")
scott = User.create(username:"scott", email: "scott@fake.com", password: "1234")
jodi = User.create(username:"jodi", email: "jodi@fake.com", password: "1234")

Subscription.create(project_id: Project.first.id, user_id: jake.id, role:"owner")
Subscription.create(project_id: Project.first.id, user_id: pat.id, role:"admin")
Subscription.create(project_id: Project.first.id, user_id: scott.id, role:"admin")
Subscription.create(project_id: Project.first.id, user_id: jodi.id, role:"collaborator")

Subscription.create(project_id: Project.all[1].id, user_id: jake.id, role:"admin")
Subscription.create(project_id: Project.all[2].id, user_id: jake.id, role:"admin")
Subscription.create(project_id: Project.all[3].id, user_id: jake.id, role:"admin")

Subscription.create(project_id: Project.all[4].id, user_id: jake.id, role:"collaborator")
Subscription.create(project_id: Project.all[5].id, user_id: jake.id, role:"collaborator")
