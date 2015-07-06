require 'bundler/setup'
Bundler.setup

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'which_time' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
end
