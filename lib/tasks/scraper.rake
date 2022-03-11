desc "Runs the Daily Reports"
namespace :scrape do

  task :transactions  => :environment do
    loop do
      Account.scrape_all
      sleep(20.minutes)
    end
  end

end