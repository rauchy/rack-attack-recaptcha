require "spec_helper"
require "ostruct"

class DummyView
  include Rack::Attack::Recaptcha::ClientHelper

  def recaptcha_tags(options)
    "yay recaptcha! #{options[:foo]}!"
  end

  def request
    @request ||= OpenStruct.new(env: {})
  end
end

module Rack
  class Attack
    module Recaptcha
      describe ClientHelper do
        describe ".recaptcha_tags_if_under_attack" do
          it "delegates to Recaptcha if under attack" do
            dummy_view = DummyView.new
            dummy_view.request.env["rack.attack.use_recaptcha"] = true

            tags = dummy_view.recaptcha_tags_if_under_attack(foo: "yay")

            tags.must_equal("yay recaptcha! yay!")
          end

          it "does nothing when not under attack" do
            dummy_view = DummyView.new

            tags = dummy_view.recaptcha_tags_if_under_attack(foo: "yay")

            tags.must_be_nil
          end
        end
      end
    end
  end
end
