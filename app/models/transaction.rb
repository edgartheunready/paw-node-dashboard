class Transaction < ApplicationRecord
  def self.scrape(tribe)
    url = tribe.as_url + "/history"
    response = JSON.parse(RestClient.get(url).body).map{|it|
      puts it
      it.delete("account")
      it[:transaction_type] = it['type']
      it.delete("type")
      it[:tribe_id] = tribe.id
      it[:created_at] = DateTime.now
      it[:updated_at] = DateTime.now
      it
    }
    Transaction.upsert_all(
      response, unique_by: "hash"
    )
  end

  def to_datetime
    Time.at(local_timestamp.to_i).to_datetime
  end

  def normalized_amount
    tmp = amount.reverse
    "#{tmp[0..26]}.#{tmp[27..tmp.size - 1]}".reverse[0..10]
  end
end