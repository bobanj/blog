class CreateSpams < ActiveRecord::Migration
  def self.up
    create_table :spams do |t|
      t.integer :post_id
      t.string :name
      t.string :email
      t.string :website
      t.text :content
      t.string :comment_type
      t.string :permalink
      t.string :user_ip
      t.string :user_agent
      t.string :referrer

      t.timestamps
    end
  end

  def self.down
    drop_table :spams
  end
end
