
@user = User.create!(email: "test@test.com", first_name: "jon", last_name: "smith", password: "asdfasdf", password_confirmation: "asdfasdf")

puts "1 User created"

@admin = AdminUser.create!(email: "admin@test.com", first_name: "Admin", last_name: "Name", password: "asdfasdf", password_confirmation: "asdfasdf")

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rational content", user_id: @user.id)
end

puts "100 posts have been created"
