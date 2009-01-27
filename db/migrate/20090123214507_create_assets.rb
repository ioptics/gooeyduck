class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.timestamps
    end
    
    create_table :attachings do |t|
      t.belongs_to :attachable, :polymorphic => true
      t.belongs_to :asset
      t.timestamps
    end
    
    add_index :attachings, [:asset_id], :name => "index_attachings_on_asset_id"
    add_index :attachings, [:attachable_id], :name => "index_attachings_on_attachable_id"
  end
  
  def self.down
    drop_table :assets
    drop_table :attachings
  end
end
