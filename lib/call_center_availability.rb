require 'call_center_availability/version'
require 'active_support/core_ext'
require 'business_time'

class CallCenterAvailability
  ## Sunday to Saturday
  ##
  OPERATING_HOURS = [
    ['00:00', '00:00'],
    ['09:00', '18:00'],
    ['09:00', '18:00'],
    ['09:00', '18:00'],
    ['09:00', '20:00'],
    ['09:00', '20:00'],
    ['09:00', '12:30'],
  ].freeze

  def initialize(time)
    @time = time
    @hour = time.strftime('%H:%M')
    @weekday = time.wday
  end

  def available?
    operating_hours? &&
      more_than_two_hours_in_the_future? &&
        less_than_six_working_days_in_the_future?
  end

  private

  def operating_hours?
    @hour.between?(
      OPERATING_HOURS[@weekday][0],
      OPERATING_HOURS[@weekday][1]
    )
  end

  def more_than_two_hours_in_the_future?
    @time >= 2.hours.from_now
  end

  def less_than_six_working_days_in_the_future?
    @time < 6.business_days.from_now
  end
end
