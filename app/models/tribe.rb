class Tribe < ApplicationRecord

  def as_url
    "https://tribes.paw.digital/api/accounts/#{uuid}"
  end
end
