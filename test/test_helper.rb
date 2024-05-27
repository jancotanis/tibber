# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'minitest/autorun'
require 'minitest/spec'

require 'dotenv'
require 'tibber'

Dotenv.load

TEST_LOGGER = 'test.log'

File.delete(TEST_LOGGER) if File.exist?(TEST_LOGGER)

Tibber.reset
Tibber.configure do |config|
  config.access_token = ENV['TIBBER_ACCESS_TOKEN']
  config.logger = Logger.new(TEST_LOGGER)
end
