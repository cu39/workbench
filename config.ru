require 'bundler'
Bundler.setup

$LOAD_PATH << File.expand_path(File.join('..','lib'), __FILE__)
require File.expand_path(File.join('..','workbench'), __FILE__)
require 'rack-livereload'

use Rack::LiveReload
run Workbench
