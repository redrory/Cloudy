desc "This task is called by the Heroku scheduler add-on"

#production scheduler
task :send_emails => :environment do
  if Time.now.sunday?
    puts "Sending emails..."
      User.weather
    puts "done."
  end
end