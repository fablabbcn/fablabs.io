# https://github.com/seejohnrun/ice_cube
# https://github.com/mlipper/runt
# http://en.wikipedia.org/wiki/Cron#Predefined_scheduling_definitions
# http://stackoverflow.com/questions/5183630/calendar-recurring-repeating-events-best-storage-method

class Event < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  attr_accessor :all_day, :location, :time_zone

  attr_writer :start_date, :start_time, :end_date, :end_time

  def time_zone
    'Madrid'
  end

  def start_date
    ActiveSupport::TimeZone.new(time_zone).utc_to_local(starts_at).stamp('30/12/99')
  end

  def start_time
    ActiveSupport::TimeZone.new(time_zone).utc_to_local(starts_at).stamp('01:45am')
  end

  def end_date
    ActiveSupport::TimeZone.new(time_zone).utc_to_local(ends_at).stamp('30/12/99')
  end

  def end_time
    ActiveSupport::TimeZone.new(time_zone).utc_to_local(ends_at).stamp('01:45am')
  end


  belongs_to :lab
  belongs_to :creator, class_name: 'User'
  validates_presence_of :name, :description, :lab #:starts_at,

  before_save :set_timezones

  scope :upcoming, -> { where('starts_at > ?', Time.now) }

  def set_timezones
    if time_zone.present?
      Chronic.time_class = ActiveSupport::TimeZone.new(time_zone)
    end
    self.starts_at = Chronic.parse( [start_date, start_time].join(' '), endian_precedence: :little)
    self.ends_at = Chronic.parse( [end_date, end_time].join(' '), endian_precedence: :little)
    # if time_zone.present?
    #   self.starts_at = ActiveSupport::TimeZone.new(time_zone).local_to_utc(starts_at)
    #   self.ends_at = ActiveSupport::TimeZone.new(time_zone).local_to_utc(ends_at)
    # end
  end

  def to_s
    name
  end

  def all_day?
    starts_at == starts_at.beginning_of_day
  end

end
