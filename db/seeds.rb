# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SecurityQuestion.create! locale: :en, name: "What is your mother's maiden name?"
SecurityQuestion.create! locale: :en, name: "Where were you born?"
SecurityQuestion.create! locale: :en, name: "What is the name of your first pet?"
SecurityQuestion.create! locale: :en, name: "What's your favorite movie?"
SecurityQuestion.create! locale: :en, name: "What's your favorite book?"
SecurityQuestion.create! locale: :en, name: "What is your favorite animal?"
SecurityQuestion.create! locale: :en, name: "What is your favorite travel destination?"