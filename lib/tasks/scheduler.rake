desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  puts "Sending emails..."
  User.weather
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end