class CreateDrafts < ActiveRecord::Migration
  def self.up
    create_table :drafts do |t|
      t.string :author
      t.string :title
      t.text :content
      t.text :markdown

      t.timestamps
    end
    add_index :drafts, [:title, :id]
  end

  def self.down
    remove_index :drafts, [:title, :id]
    drop_table :drafts
  end
end
