class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :name
      t.string :email
      t.string :website
      t.text :content
      t.boolean :admin
      t.string :comment_type
      t.string :permalink
      t.string :user_ip
      t.string :user_agent
      t.string :referrer

      t.timestamps
    end
    add_index :comments, [:post_id]
    add_index :comments, [:admin]
    add_index :comments, [:comment_type]
    add_index :comments, [:post_id,:comment_type]
    add_index :comments, [:post_id, :admin]
  end

  def self.down
    remove_index :comments, [:post_id]
    remove_index :comments, [:admin]
    remove_index :comments, [:comment_type]
    remove_index :comments, [:post_id,:comment_type]
    remove_index :comments, [:post_id, :admin]
    drop_table :comments
  end
end
