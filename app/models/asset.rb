class Asset < ActiveRecord::Base
  has_many :attachings, :dependent => :destroy
  has_attached_file :data,
                    :styles => { :xsmall => "64x64#",
                                 :small  => "150x120#",
                                 :medium => "400x350>",
                                 :large  => "600x500>",
                                 :xlarge => "800x600>" }
  
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def browser_safe?
    %w(jpg gif png).include?(url.split('.').last.downcase)
  end
  alias_method :web_safe?, :browser_safe?
  
  # This method assumes you have images that corespond to the filetypes.
  # For example "image/png" becomes "image-png.png"
  def icon
    "#{data_content_type.gsub(/[\/\.]/,'-')}.png"
  end
    
  def detach(attached)
    a = attachings.find(:first, :conditions => ["attachable_id = ? AND attachable_type = ?", attached, attached.class.to_s])
    raise ActiveRecord::RecordNotFound unless a
    a.destroy
  end
end