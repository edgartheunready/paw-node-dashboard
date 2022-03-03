class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :account_id
      t.string :amount
      t.string :local_timestamp
      t.string :height
      t.string :hash
      t.boolean :confirmed

      t.timestamps
    end
  end
end
