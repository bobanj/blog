class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.references :post
      t.references :tag

      t.timestamps
    end
    add_index :taggings, :post_id
    add_index :taggings, :tag_id
  end

  def self.down
    remove_index :taggings, :post_id
    remove_index :taggings, :tag_id
    drop_table :taggings
  end
end
