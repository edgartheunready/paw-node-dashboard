class ChangeTransactionsToTribeTransactions < ActiveRecord::Migration[7.0]
  def change
    rename_table :transactions, :account_transactions
    rename_table :tribes, :accounts
    rename_column :account_transactions, :tribe_id, :account_id
    rename_column :account_transactions, :hash, :transaction_hash
  end
end
