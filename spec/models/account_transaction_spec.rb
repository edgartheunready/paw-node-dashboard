require "rails_helper"  # this

RSpec.describe AccountTransaction, type: :model  do

  describe "to_datetime" do
    it "turns seconds since epoch into datetimes" do
      transaction = AccountTransaction.create(local_timestamp: "1646356275")
      expect(transaction.to_datetime.strftime("%D %T")).to eq("03/03/22 20:11:15")
    end
  end

  it "sets created_at based on local_timestamp" do
    at = AccountTransaction.create(local_timestamp: "1646356275")
    expect{
      at.set_transaction_at
    }.to change{
     at.reload.created_at 
    }
  end

  it "scrapes account data" do
    account = Account.create(uuid: "paw_1qfe5u7bcm7qrpp9rhk9p7wyqw316om1ts7s4gm466nwy6ueniik1gzwcno8")


    RestClient = double
    data =  File.read("test/fixtures/transactions.json")

    response = double
    response.stub(:code) { 200 }
    response.stub(:body) { data }
    response.stub(:headers) { {} }
    RestClient.stub(:get) { response }  


    expect{
      AccountTransaction.scrape(account)
    }.to change{
      AccountTransaction.count    
    }.by(20)

    transaction = AccountTransaction.last
    expect(transaction.target_account).to eq("paw_1k94ieq4xj8jjniryf33ot7cehkx3k9k13bcnwnsm986w7fwu6f3zym9srhn")

    expect{
      AccountTransaction.scrape(account)
    }.to change{
      AccountTransaction.count    
    }.by(0)

    expect(AccountTransaction.last.to_datetime.strftime("%D %T")).to eq("03/03/22 20:10:37")
  end
end
