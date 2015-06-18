class Document < ActiveRecord::Base
  belongs_to :project

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :image, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /bmp\Z/]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 15.megabytes


  def s3_credentials
    {
      :bucket => ENV['S3_BUCKET'],
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET'],
      :region => "eu-west-1"
    }
  end

end
