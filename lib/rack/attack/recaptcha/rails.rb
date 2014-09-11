ActionView::Base.send(:include, Rack::Attack::Recaptcha::ClientHelper)
ActionController::Base.send(:include, Rack::Attack::Recaptcha::VerificationHelper)
