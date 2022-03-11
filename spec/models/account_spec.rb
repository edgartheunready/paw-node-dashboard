require "rails_helper"  # this

RSpec.describe Account, type: :model  do

  describe "generate_trends" do
    it "generates trends for the last hour, 12 hours, and day" do
      account = Account.create(name: "test")
      AccountTransaction.create(created_at: 1.minute.ago, account: account)
      AccountTransaction.create(created_at: 2.hours.ago, account: account)
      AccountTransaction.create(created_at: 22.hours.ago, account: account)
      AccountTransaction.create(created_at: 2.days.ago, account: account)
      expected_result = [
        ["Account", "last hour", "last 12", "last day", "last week"],
        ["test", 1, 2, 3, 4]
      ]
      expect(Account.generate_trends).to eq(expected_result)
    end
  end
  
end
