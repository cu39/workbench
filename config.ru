require 'bundler'
Bundler.setup

require File.expand_path(File.join('..','workbench'), __FILE__)
require 'rack-livereload'

use Rack::LiveReload
run Workbench
