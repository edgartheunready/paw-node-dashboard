class Account < ApplicationRecord
  has_many :account_transactions

  def self.scrape_all
    Account.find_each{|account|
        AccountTransaction.scrape(account)
    }
  end

  def as_url
    "https://tribes.paw.digital/api/accounts/#{uuid}"
  end

  def self.generate_trends
    response = [["Account", "last hour", "last 12", "last day", "last week"]]
    now = DateTime.now
    last_hour = (now - 1.hour..now)
    last_twelve = (now - 12.hour..now)
    last_day = (now - 1.day..now)
    last_week = (now - 1.week..now)
    Account.find_each{|account|

      response << [
        account.name,
        account.account_transactions.where(created_at: last_hour).count,
        account.account_transactions.where(created_at: last_twelve).count,
        account.account_transactions.where(created_at: last_day).count,
        account.account_transactions.where(created_at: last_week).count,
      ]
    }
    response
  end
end
