desc "Runs the Daily Reports"
namespace :scrape do

  task :transactions  => :environment do
    Tribe.find_each{|tribe|
      Transaction.scrape(tribe)
    }
  end

end