User.create!( email: "admin@gmail.com", name: "Admin", password: "123123", role: "admin")
User.create!( email: "member@gmail.com", name: "Member", password: "123123", role: "member")

["Ruby","Javascript", "Mysql", "HTML5", "ReactJs"].each do |name|
  Category.create! name: name, user_id: User.where(role: "admin").sample.id
end

200.times do |question|
  Question.new(category_id: rand(1..5), question_content: "Question name #{question+1}", level: rand(0..1)).save(validate: false)
end
