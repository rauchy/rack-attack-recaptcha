if defined?(Rails)
  require "recaptcha/rails"

  ActionView::Base.send(:include, Rack::Attack::Recaptcha::ClientHelper)
  ActionController::Base.send(:include, Rack::Attack::Recaptcha::VerificationHelper)
end
