
namespace :scheduler do

  desc "This task is called by Heroku Scheduler add-on to send a reminder to the customers one day before the reservation"
  task :send_reminders => :environment do
    Customer.send_reminders
  end

end