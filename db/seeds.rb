
@user = User.create!(email: "test@test.com", first_name: "jon", last_name: "smith", password: "asdfasdf", password_confirmation: "asdfasdf")

puts "1 User created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rational content", user_id: @user.id)
end

puts "100 posts have been created"
