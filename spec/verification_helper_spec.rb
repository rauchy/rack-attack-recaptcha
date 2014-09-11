require "spec_helper"
require "ostruct"

class DummyController
  include Rack::Attack::Recaptcha::VerificationHelper

  def verify_recaptcha(options)
    "yay recaptcha! #{options[:foo]}!"
  end

  def request
    @request ||= OpenStruct.new(env: {})
  end
end

module Rack
  module Attack
    module Recaptcha
      describe ClientHelper do
        describe ".verify_recaptcha_if_under_attack" do
          it "delegates to Recaptcha if under attack" do
            dummy_controller = DummyController.new
            dummy_controller.request.env["rack.attack.use_recaptcha"] = true

            verification = dummy_controller.verify_recaptcha_if_under_attack(foo: "yay")

            verification.must_equal("yay recaptcha! yay!")
          end

          it "returns true by default when not under attack" do
            dummy_controller = DummyController.new

            verification = dummy_controller.verify_recaptcha_if_under_attack(foo: "yay")

            verification.must_equal true
          end
        end
      end
    end
  end
end
