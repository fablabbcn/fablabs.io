# https://github.com/seejohnrun/ice_cube
# https://github.com/mlipper/runt
# http://en.wikipedia.org/wiki/Cron#Predefined_scheduling_definitions
# http://stackoverflow.com/questions/5183630/calendar-recurring-repeating-events-best-storage-method

class Event < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  belongs_to :lab
  belongs_to :creator, class_name: 'User'
  validates_presence_of :name, :description, :lab #:starts_at,

  attr_accessor :all_day, :location, :time_zone
  attr_writer :start_date, :start_time, :end_date, :end_time

  scope :upcoming, -> { where('starts_at > ?', Time.now) }

  Tags = %w(open_days workshops lectures social_party)
  bitmask :tags, as: Tags

  def time_zone
    'Madrid'
  end

  def to_s
    name
  end

  def all_day?
    starts_at == starts_at.beginning_of_day
  end

  %w(start end).each do |word|

    define_method "#{word}_date" do
      ActiveSupport::TimeZone.new(time_zone).utc_to_local(self["#{word}s_at"]).stamp('30/12/99') if self["#{word}s_at"].present?
    end

    define_method "#{word}_time" do
      ActiveSupport::TimeZone.new(time_zone).utc_to_local(self["#{word}s_at"]).stamp('01:45am') if self["#{word}s_at"].present?
    end

  end

private

end
