desc "Runs the Daily Reports"
namespace :scrape do

  task :transactions  => :environment do
    loop do
      Account.find_each{|account|
        AccountTransaction.scrape(account)
        sleep(rand(5..30))
      }
      sleep(20.minutes)
    end
  end

end