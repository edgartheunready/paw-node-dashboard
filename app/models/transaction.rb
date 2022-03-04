class Transaction < ApplicationRecord
  def self.scrape(tribe)
    url = tribe.as_url + "/history"
    response = JSON.parse(RestClient.get(url).body).map{|it|
      puts it
      it.delete("account")
      it[:tribe_id] = tribe.id
      it[:created_at] = DateTime.now
      it[:updated_at] = DateTime.now
      it
    }
    Transaction.upsert_all(
      response, unique_by: "hash"
    )
  end
end