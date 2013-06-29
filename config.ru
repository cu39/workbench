require 'bundler'
Bundler.setup

require 'rack-livereload'
use Rack::LiveReload

require File.expand_path(File.join('..','workbench'), __FILE__)

map Workbench.sprockets_prefix do
  run Workbench.sprockets
end

map '/' do
  run Workbench
end
