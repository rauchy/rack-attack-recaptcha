require "rack/attack"
require "rack/attack/recaptcha/version"
require "rack/attack/recaptcha/client_helper"
require "rack/attack/recaptcha/verification_helper"
require "rack/attack/recaptcha/rails"
require "rack/attack/recaptcha/middleware"

module Rack
  class Attack
    module Recaptcha
      class << self
        def new(app)
          Rack::Attack::Recaptcha::Middleware.new(app)
        end
      end
    end
  end
end
