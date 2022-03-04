class Tribe < ApplicationRecord
  has_many :transactions
  def as_url
    "https://tribes.paw.digital/api/accounts/#{uuid}"
  end
end
