module Rack
  class Attack
    module Recaptcha
      class Middleware
        def initialize(app)
          @default_response = Rack::Attack.throttled_response
          @rack_attack = Rack::Attack.new(app).tap do |attack|
            attack.class.throttled_response = lambda do |env|
              if env["rack.attack.match_type"] == :recaptcha
                env["rack.attack.use_recaptcha"] = true
                app
              else
                @default_response
              end.call(env)
            end
          end
        end

        def call(env)
          @rack_attack.call(env)
        end
      end
    end
  end
end
