class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :commentable
      t.string :author
      t.text :markdown
      t.datetime :posted_at

      t.timestamps
    end
    add_index :posts, [:title, :id, :posted_at]
    add_index :posts, [:title, :id, :updated_at]
    add_index :posts, [:title, :author, :id, :posted_at]
    add_index :posts, [:title, :author, :id, :content, :posted_at]
  end

  def self.down
    remove_index :posts, [:title, :id, :posted_at]
    remove_index :posts, [:title, :id, :updated_at]
    remove_index :posts, [:title, :author, :id, :posted_at]
    remove_index :posts, [:title, :author, :id, :content, :posted_at]
    drop_table :posts
  end
end
