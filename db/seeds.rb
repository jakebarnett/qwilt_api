require 'faker'

10.times do
	Project.create!(
		title: Faker::Company.name,
		description: Faker::Hacker.say_something_smart
	)
end
