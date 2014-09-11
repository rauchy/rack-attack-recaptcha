module Rack
  module Attack
    module Recaptcha
      module ClientHelper
        def recaptcha_tags_if_under_attack(options={})
          recaptcha_tags(options) if request.env["rack.attack.use_recaptcha"]
        end
      end
    end
  end
end
