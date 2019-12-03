# Call Center Availability

Write a class or module which, when given a requested time for a
pre-booked call, will give a response to say whether or not that is
a valid time.

Setup:

    $ bundle

## Usage

To use the class you can instantiate passing the time and check with
CallCenterAvailability#available? method.

You can play in irb:

```
   $ irb -Ilib
```

```ruby
   ## e.g case now is 04th December 2019 09:00
   invalid_times = [
     Time.now + 1.hour,
     Time.now + 7.days,
     Time.new(2019, 12, 8, 13),
     Time.new(2019, 12, 7, 23)
   ]

   ## e.g now is 04th December 2019 09:00
   valid_times = [
     Time.new(2019, 12, 6, 11),
     Time.new(2019, 12, 7, 11)
   ]

   invalid_times.each do |invalid_time|
     call_center = CallCenterAvailability.new(invalid_time)
     puts "#{invalid_time} - #{call_center.available?}"
   end

   valid_times.each do |valid_time|
     call_center = CallCenterAvailability.new(valid_time)
     puts "#{valid_time} - #{call_center.available?}"
   end
```

## Tests

To run the tests:

    $ rspec spec

## Rubocop

To run the linter:

    $ rubocop

## Documentation

You can run the documentation and open by running:

    $ yardoc 'lib/**/*.rb'
    $ open doc/index.html
