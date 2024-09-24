class CreateJoinTableTagsGossips < ActiveRecord::Migration[6.1]
  def change
    create_join_table :tags, :gossips do |t|
      t.index :tag_id
      t.index :gossip_id
    end
  end
end
