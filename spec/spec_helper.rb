# frozen_string_literal: true

require 'rspec'
require 'flitt_api'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
