# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


every 1.day, :at => '10:10 am' do
  runner "User.weather", :environment => "production"
end

every :sunday, :at => '1:00 am' do
  runner "User.weather", :environment => "development"
end