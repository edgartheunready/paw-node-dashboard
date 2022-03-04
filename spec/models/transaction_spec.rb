require "rails_helper"  # this

RSpec.describe Transaction, type: :model  do

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
  end
end
