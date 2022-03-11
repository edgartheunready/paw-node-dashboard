class AddTargetAccountToAccountTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :account_transactions, :target_account, :string
  end
end
