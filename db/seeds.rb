100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rational content")
end

puts "100 posts have been created" 
