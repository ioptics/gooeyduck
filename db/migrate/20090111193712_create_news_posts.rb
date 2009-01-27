class CreateNewsPosts < ActiveRecord::Migration
  def self.up
    create_table :news_posts, :force => true do |t|
      t.string :title
      t.text :summary
      t.text :body
      t.string :author
      t.integer :comments_count, :default => 0
      t.integer  :assets_count, :default => 0
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.datetime :published_at
      t.timestamps
    end
    
    add_index :news_posts, [:created_by_id, :updated_by_id]
  end

  def self.down
    drop_table :news_posts
  end
end
