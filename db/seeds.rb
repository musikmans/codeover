# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Quiz.destroy_all
Question.destroy_all
User.destroy_all
Answer.destroy_all

PASSWORD = "supersecret"

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    password: "supersecret",
    admin: true
)

10.times do
    full_name = Faker::FunnyName.two_word_name.split(" ")

    User.create(
        first_name: full_name[0],
        last_name: full_name[-1],
        email: Faker::Internet.email,
        password: PASSWORD
    )
end

users = User.all

100.times do
    quiz_creator = users.sample

    q = Quiz.create(
        name: Faker::Lorem.words(5, true),
        description: Faker::Lorem.sentence(1, true, 5),
        user: quiz_creator
    )

    if q.valid?
        rand(0..25).times do
            q.questions << Question.new(
                body: Faker::Lorem.sentence(1, true, 2),
                points: rand(5..25),
                user: quiz_creator
            )

        end
    end
end