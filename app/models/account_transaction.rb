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

  def self.payouts
    where(target_account: [nil, 'paw_1qfe5u7bcm7qrpp9rhk9p7wyqw316om1ts7s4gm466nwy6ueniik1gzwcno8'], transaction_type: "receive")
  end

  def self.hourly_by_account
    Time.zone = "Eastern Time (US & Canada)"
    results = {}
     payouts.where(created_at:(1.day.ago..0.days.ago)).map{|it| 
      if results[it.account_id].nil?
        results[it.account_id] = Hash.new(0)
      end
      results[it.account_id][it.created_at.strftime("%I %P")] += 1
    }
    
    {
      data: results,
      keys: (0..23).map{|it|
        it.hours.ago.strftime("%I %P")
      }
    }
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