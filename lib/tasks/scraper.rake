desc "Runs the Daily Reports"
namespace :scraper do

  task :accounts  => :environment do
    TransactionScraper.do_task
  end

end