# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:                  "Abdul Rehman",
						 email:                 "arehman674@gmail.com",
						 password:              "123456",
						 password_confirmation: "123456")


25.times do |n|
	User.create!(name:                  Faker::Name.name,
							 email:                 "abc#{n+2}@gmail.com",
							 password:              "123456",
							 password_confirmation: "123456")
end

users = User.all.ids.to_a
50.times do |n|
	title = "Question-#{n+1} - #{Faker::Lorem.sentence}?"
	content = %W(a b c d e f g h i j k l m n o p q r s t u v w x y z \n)
	content = Faker::Lorem.paragraph(8, false, 15)
	votes = rand(200)
	Question.create!(title:    title,
									 content:  content,
									 votes:    votes,
									 user_id:  users[rand(25)])
end


100.times do |n|
	question_id = 1 + rand(50)
	content = Faker::Lorem.paragraph(5, false, 10)
	votes = rand(500)

	if Answer.find_by(question_id: question_id, accepted: true)
		accepted = false
	else
		accepted = Faker::Boolean.boolean
	end

	Answer.create!(content:     content,
								 votes:       votes,
								 question_id: question_id,
								 accepted:    accepted)

end

tags = %w(java c++ python ruby rails c C# F# scala perl ubuntu windows programing html css js jQuery UI bootstrap)

Question.all.each do |question|
	(3 + rand(4)).times do
		tag = tags[rand(tags.size)]
		if question.categories.find_by(tag: tag).blank?
			question.categories.create!(tag: tag)
		end
	end
end