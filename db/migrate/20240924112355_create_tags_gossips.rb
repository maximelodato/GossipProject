class CreateTagsGossips < ActiveRecord::Migration[7.1]
  def change
    create_table :tags_gossips do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :gossip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
