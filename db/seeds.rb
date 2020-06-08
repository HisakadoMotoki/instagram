# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(password:"passward", email: "sagamihara717771@gmail.com", name: "hisakadomotoki", username: "ktd", profile: "hello!immotoki", link: "httpl;;feffef.com", tel: "09011111111", sex: 1)

  Picture.create!(name: "#{n}名前",
                email: "email#{n}@example.com",
                image: open("#{Rails.root}/app/images/default.png")
              )
    Picture.create!(title: "kpkpkpk", description: "kppkpkp", user_id: 1,image: open("#{Rails.root}/app/images/default.png"))