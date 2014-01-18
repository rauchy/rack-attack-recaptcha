# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/attack/recaptcha/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-attack-recaptcha"
  spec.version       = Rack::Attack::Recaptcha::VERSION
  spec.authors       = ["Omer Lachish-Rauchwerger"]
  spec.email         = ["omer@rauchy.net"]
  spec.description   = %q{An extension for Rack::Attack that supports responding to throttled requests with Recaptcha tags}
  spec.summary       = %q{Block & throttle abusive requests with Recaptcha}
  spec.homepage      = "http://github.com/rauchy/rack-attack-recaptcha"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-attack"
  spec.add_development_dependency "recaptcha"
end
