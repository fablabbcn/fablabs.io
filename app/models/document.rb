class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => :true

  has_attached_file :image,
                    :styles => { :large => "1200x1200>",
                                 :medium => "640x640>",
                                 :thumb => "250x250>" }

  dragonfly_accessor :photo
end
