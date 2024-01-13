class Academic < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'AcademicAuthorizer'
# t.belongs_to :user
# t.belongs_to :lab
# t.integer :started_in
# t.string :type
# t.belongs_to :approver
# meta

  Favourites = [
    :molding_and_casting,
    :group_project
  ]

  Disciplines = [
    :final_project,
    :electronics_programming,
    :circuit_design,
    :three_d_design,
    :vinyl_cutting,
    :laser_cutting,
    :three_d_printing,
    :three_d_scanning,
    :composites,
  ]

  belongs_to :user
  belongs_to :lab
  belongs_to :approver, class_name: 'User'

  validates_presence_of :started_in, :lab, :user

  store_accessor :meta,
    :graduated_in,
    :url,
    :fp_name,
    :fp_description,
    :fp_url,
    :fp_photo,
    :comments,
    :favourites

end
