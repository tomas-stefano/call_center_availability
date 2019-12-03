require 'call_center_availability/version'
require 'active_support/core_ext'
require 'business_time'

## I was in doubt if I should change to CallCenter but both choices
#  sounded right.
#
# CallCenterAvailability.
#
# Checks for the call center availability
#
# @example
#
#   ## e.g case now is 04th December 2019 09:00
#   invalid_times = [
#     Time.now + 1.hour,
#     Time.now + 7.days,
#     Time.new(2019, 12, 8, 13),
#     Time.new(2019, 12, 7, 23)
#   ]
#
#   ## e.g now is 04th December 2019 09:00
#   valid_times = [
#     Time.new(2019, 12, 6, 11),
#     Time.new(2019, 12, 7, 11)
#   ]
#
#   invalid_times.each do |invalid_time|
#     call_center = CallCenterAvailability.new(invalid_time)
#     puts "#{invalid_time} - #{call_center.available?}"
#   end
#
#   valid_times.each do |valid_time|
#     call_center = CallCenterAvailability.new(valid_time)
#     puts "#{valid_time} - #{call_center.available?}"
#   end
#
class CallCenterAvailability
  ## Sunday to Saturday
  ## Maybe I should refactor the days that has same values but I
  ## feel that would be an unecessary optimization.
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

  # @param [Time] time Receives time of the pre booked call
  #
  def initialize(time)
    @time = time
    @hour = time.strftime('%H:%M')
    @weekday = time.wday
  end

  ## @return [true] if call center has availability.
  ##
  ## @return [false] if out of hours, earlier than 2 hours in
  #   the future and more than 6 working days in the future.
  ##
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
