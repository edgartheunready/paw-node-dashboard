class Account < ApplicationRecord
  has_many :account_transactions
  def as_url
    "https://tribes.paw.digital/api/accounts/#{uuid}"
  end
end
