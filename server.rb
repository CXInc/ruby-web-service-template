require "sinatra"
require "sinatra/json"
require "rack/parser"
require "newrelic_rpm"

require "./config/app_config"

require "./lib/json_helpers"
require "./lib/error_handling"

set :protection, :except => [:json_csrf]

configure do
  file = File.new("#{settings.root}/log/#{settings.environment}.log", "a+")
  file.sync = true
  use Rack::CommonLogger, file

  use Rack::Parser, parsers: {
    "application/json"  => Proc.new { |body| ::MultiJson.decode body },
    "application/xml" => Proc.new { |body| Nori.new.parse body }
  }
end

get '/' do
  json status: "Awaiting your command"
end
