class CreateNewsPosts < ActiveRecord::Migration
  def self.up
    create_table :news_posts, :force => true do |t|
      t.column :title, :string
      t.column :summary, :text
      t.column :body, :text
      t.column :published_at, :datetime
    end
  end

  def self.down
    drop_table :news_posts
  end
end
