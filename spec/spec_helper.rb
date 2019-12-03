require 'bundler/setup'
Bundler.require(:test)
require 'call_center_availability'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
