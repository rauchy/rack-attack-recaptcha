module Rack
  module Attack
    module Recaptcha
      module VerificationHelper
        def verify_recaptcha_if_under_attack(options)
          if request.env["rack.attack.use_recaptcha"]
            verify_recaptcha(options)
          else
            true
          end
        end
      end
    end
  end
end
