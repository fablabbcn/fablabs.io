class Event < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  include DateTimeAttribute
  attr_accessor :all_day, :location, :time_zone
  # attr_accessor :starts_at, :ends_at
  # date_time_attribute :starts_at, :ends_at

  belongs_to :lab
  belongs_to :creator, class_name: 'User'
  validates_presence_of :name, :description, :lab #:starts_at,

  before_save :set_timezones

  def set_timezones
    self.starts_at = ActiveSupport::TimeZone.new(time_zone).local_to_utc(starts_at)
    self.ends_at = ActiveSupport::TimeZone.new(time_zone).local_to_utc(ends_at)
  end

  def to_s
    name
  end

  def all_day?
    starts_at == starts_at.beginning_of_day
  end

end
