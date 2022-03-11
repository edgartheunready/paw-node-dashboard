class AccountTransaction < ApplicationRecord
  belongs_to :account, optional: true
  def self.scrape(account)
    url = account.as_url + "/history"
    response = JSON.parse(RestClient.get(url).body).map{|it|
      it[:target_account] = it['account']
      it.delete("account")
      it[:transaction_type] = it['type']
      it[:transaction_hash] = it['hash']
      it.delete("hash")
      it.delete("type")
      it[:account_id] = account.id
      it[:created_at] = Time.at(it["local_timestamp"].to_i).to_datetime
      it[:updated_at] = DateTime.now
      it
    }
    AccountTransaction.upsert_all(
      response, unique_by: "transaction_hash"
    )
  end

  def to_datetime
    Time.at(local_timestamp.to_i).to_datetime
  end

  def normalized_amount
    tmp = amount.reverse
    "#{tmp[0..26]}.#{tmp[27..tmp.size - 1]}".reverse[0..10]
  end

  def self.analyze
    AccountTransaction.all.map{|it| it.to_datetime.strftime("%M")[1]}.inject(Hash.new(0)){|h, e| h[e] += 1; h}
  end

  def set_transaction_at
    now = to_datetime()
    return if now.to_time.nil?
    puts now
    puts now.blank?
    update(created_at: now.to_time)
  end
end