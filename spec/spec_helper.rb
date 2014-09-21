require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "rack/attack/recaptcha"
require "active_support"

require 'rspec/mocks'

module MinitestRSpecMocksIntegration
  include ::RSpec::Mocks::ExampleMethods

  def before_setup
    ::RSpec::Mocks.setup
    super
  end

  def after_teardown
    super
    ::RSpec::Mocks.verify
  ensure
    ::RSpec::Mocks.teardown
  end
end

Minitest::Spec.send(:include, MinitestRSpecMocksIntegration)
