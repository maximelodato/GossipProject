class CreateSenders < ActiveRecord::Migration[7.0]
  def change
    create_table :senders do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
