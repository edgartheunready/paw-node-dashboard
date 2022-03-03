class CreateTribes < ActiveRecord::Migration[7.0]
  def change
    create_table :tribes do |t|
      t.string :name
      t.string :uuid

      t.timestamps
    end
  end
end
