desc "Runs the Daily Reports"
namespace :scrape do

  task :transactions  => :environment do
    Tribe.find_each{|tribe|
      Transaction.scrape(tribe)
      sleep(rand(5..30))
    }
  end

end