
@user = User.create!(email: "tester@test.com", first_name: "jon", last_name: "smith", password: "asdfasdf", password_confirmation: "asdfasdf")

puts "1 User created"

@admin = AdminUser.create!(email: "2admin@test.com", first_name: "Admin", last_name: "Name", password: "asdfasdf", password_confirmation: "asdfasdf")

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rational content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"
