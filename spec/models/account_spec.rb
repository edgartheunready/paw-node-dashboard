require "rails_helper"  # this

RSpec.describe Account, type: :model  do

  describe "generate_trends" do
    it "generates trends for the last hour, 12 hours, and day" do
      account = Account.create(name: "test")
      AccountTransaction.create(created_at: 1.minute.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 66.minutes.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 2.hours.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 3.hours.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 5.hours.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 7.hours.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 22.hours.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 2.days.ago, account: account, transaction_type: "receive")
      AccountTransaction.create(created_at: 4.days.ago, account: account, transaction_type: "receive")
      expected_result = [
        ["Account", "last hour", "last 3", "last 6", "last 12", "last day", "last 3 days", "last week"],
        ["test", 1, 3, 5, 6, 7, 8, 9]
      ]
      expect(Account.generate_trends).to eq(expected_result)
    end
  end
  
  describe "generate_payouts" do
    it "generates payout totals for the last hour, 12 hours, and day" do
      account = Account.create(name: "test")
      AccountTransaction.create(created_at: 1.minute.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 66.minutes.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 2.hours.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 3.hours.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 5.hours.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 7.hours.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 22.hours.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 2.days.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      AccountTransaction.create(created_at: 4.days.ago, account: account, amount: "1000000000000000000000000000", transaction_type: "receive")
      expected_result = [
        ["Account", "last hour", "last 3", "last 6", "last 12", "last day", "last 3 days", "last week"],
        ["test", 1, 3, 5, 6, 7, 8, 9]
      ]
      expect(Account.generate_payouts).to eq(expected_result)
    end
  end

end
