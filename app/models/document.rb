class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => :true

  has_attached_file :image,
                    :styles => { :large => "1200x1200>",
                                 :medium => "640x640>",
                                 :thumb => "250x250>" }

  validates :image, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/i, /jpe?g\Z/i, /gif\Z/i, /bmp\Z/i]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 15.megabytes



end
