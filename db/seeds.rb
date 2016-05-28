require 'faker'

20.times do
	Project.create!(
		title: Faker::Company.name,
		description: Faker::Hacker.say_something_smart
	)
end

Project.all.each do |project|
	30.times do
		project.squares.create!(
			title: Faker::Number.number(6),
			position: [Faker::Number.number(1), Faker::Number.number(1)]
		)
	end
end
