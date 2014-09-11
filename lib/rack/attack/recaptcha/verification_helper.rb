module Rack
  module Attack
    module Recaptcha
      module VerificationHelper
        def verify_recaptcha_if_under_attack(options)
          verify_recaptcha(options) if request.env["rack.attack.use_recaptcha"]
        end
      end
    end
  end
end
