class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => :true

  extend DragonflyValidations
  dragonfly_accessor :photo
  dragonfly_validations :photo

  def photo_url
    self.photo && self.photo.url || nil
  end

end
