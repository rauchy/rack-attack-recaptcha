require_relative "spec_helper"

describe "Rack::Attack::Recaptcha" do
  include Rack::Test::Methods

  def set_last_env(env)
    @last_env = env
  end

  def app
    that = self
    Rack::Builder.new {
      use Rack::Attack::Recaptcha
      run lambda {|env| that.set_last_env(env) ; [200, {}, ["Hello World"]]}
    }.to_app
  end

  before do
    @bad_ip = "1.2.3.4"
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    Rack::Attack.throttle("req/ip", :limit => 1, :period => 1) { |req| req.ip }
  end

  it "always delegates request to the underlying app" do
    get "/", {}, "REMOTE_ADDR" => @bad_ip

    last_response.body.must_equal "Hello World"
  end

  it "doesn't add a recaptcha flag to the environment when throttle is below the limit" do
    get "/", {}, "REMOTE_ADDR" => @bad_ip

    @last_env.keys.wont_include "rack.attack.use_recaptcha"
  end

  it "adds a recaptcha flag to the environment when hitting the throttle limit" do
    10.times { get "/", {}, "REMOTE_ADDR" => @bad_ip }

    @last_env["rack.attack.use_recaptcha"].must_equal true
  end
end
