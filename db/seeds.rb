bojack = User.create!(username: "bojack_horseman", email: "bojack@horse.com", password: "1234")
caroline = User.create!(username: "princess_caroline", email: "caroline@cat.com", password: "1234")
todd = User.create!(username: "todd", email: "todd@human.com", password: "1234")

survey_1 = bojack.created_surveys.create(title: Faker::Book.title, category: Faker::Commerce.department)
survey_2 = bojack.created_surveys.create(title: Faker::Commerce.color, category: Faker::Commerce.department)
survey_3 = caroline.created_surveys.create(title: Faker::Team.sport, category: Faker::Commerce.department)

5.times do
	survey_1.questions.create(body: Faker::Team.creature)
end
3.times do
	survey_1.questions.each do |question|
		question.choices.create(body: Faker::Company.catch_phrase)
	end
end


5.times do
	survey_2.questions.create(body: Faker::Team.creature)
end
3.times do
	survey_2.questions.each do |question|
		question.choices.create(body: Faker::Lorem.word)
	end
end

5.times do
	survey_3.questions.create(body: Faker::Team.state)
end
3.times do
	survey_3.questions.each do |question|
		question.choices.create(body: Faker::Name.name)
	end
end

