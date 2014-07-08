require 'rack/test'
require 'json_spec/cucumber'

ENV["RACK_ENV"] = "test"

require_relative "../../server"

module AppHelper
  def app
    Sinatra::Application
  end
end

World(Rack::Test::Methods)
World(AppHelper)

# For json_spec
def last_json
  @response.body
end
