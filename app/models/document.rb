class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => :true

  dragonfly_accessor :photo
end
