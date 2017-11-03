namespace :notification do
  desc "Sends SMS notifications to employees asking them to log overtime"
  task sms: :environment do
    puts "I'm in a rake task"
    # 1. Schedule Sunday at 5PM
    # 2. Iterate over all employees
    # 3. Skip Admin users
    # 4. Send link that has instructions and a link to log time  
  end

end
