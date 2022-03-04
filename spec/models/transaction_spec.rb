require "rails_helper"  # this

RSpec.describe Transaction, type: :model  do

  describe "to_datetime" do
    xit "turns seconds since epoch into datetimes" do
      transaction = Transaction.create(local_timestamp: "1646356275")
      expect(transaction.to_datetime.strftime("%D %T")).to eq("")
    end
  end

  it "scrapes account data" do
    tribe = Tribe.create(uuid: "paw_1qfe5u7bcm7qrpp9rhk9p7wyqw316om1ts7s4gm466nwy6ueniik1gzwcno8")


    RestClient = double
    data =  File.read("test/fixtures/transactions.json")

    response = double
    response.stub(:code) { 200 }
    response.stub(:body) { data }
    response.stub(:headers) { {} }
    RestClient.stub(:get) { response }  


    expect{
      Transaction.scrape(tribe)
    }.to change{
      Transaction.count    
    }.by(20)

    expect{
      Transaction.scrape(tribe)
    }.to change{
      Transaction.count    
    }.by(0)

    expect(Transaction.last.to_datetime.strftime("%D %T")).to eq("03/03/22 20:10:37")
  end
end
