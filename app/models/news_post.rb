class NewsPost < ActiveRecord::Base
  acts_as_polymorphic_paperclip
  acts_as_taggable

  validates_presence_of :title, :body
  
  named_scope :recent, :order => 'created_at desc', :limit => 10
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end
end