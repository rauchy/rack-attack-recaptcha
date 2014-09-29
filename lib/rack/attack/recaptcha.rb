require "rack/attack"
require "rack/attack/recaptcha/version"
require "rack/attack/recaptcha/client_helper"
require "rack/attack/recaptcha/verification_helper"
require "rack/attack/recaptcha/rails"

module Rack
  class Attack
    module Recaptcha
      class << self
        def new(app)
          @default_response = Rack::Attack.throttled_response
          @rack_attack = Rack::Attack.new(app).tap { |attack|
            attack.class.throttled_response = lambda { |env|
              if env["rack.attack.match_type"] == :recaptcha
                env["rack.attack.use_recaptcha"] = true
                app
              else
                @default_response
              end.call(env)
            }
          }

          self
        end

        def call(env)
          @rack_attack.call(env)
        end
      end
    end
  end
end
