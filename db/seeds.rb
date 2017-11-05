
@user = User.create!(email: "tester@test.com",
                    first_name: "jon",
                    last_name: "smith",
                    password: "asdfasdf",
                    password_confirmation: "asdfasdf",
                    phone: "5555555555")

puts "1 User created"

@admin = AdminUser.create!(email: "Admin@test.com",
                            first_name: "Admin",
                            last_name: "Name",
                            password: "asdfasdf",
                            password_confirmation: "asdfasdf",
                            phone: "5555555555")



100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rational content", user_id: @user.id, overtime_request: 2.5)
end
puts "100 posts have been created"

100.times do |audit_log|
  AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 6.days))
end

puts "100 audit logs have been created"
