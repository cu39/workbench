require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'
require 'sass'
require 'compass'
require 'bootstrap-sass'
require 'coffee-script'
require 'sprockets'
require 'sprockets-helpers'
require 'sprockets-sass'

class Workbench < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :sprockets, Sprockets::Environment.new(settings.root)
  set :sprockets_prefix, '/assets'
  set :digest_assets, false

  configure do
    Sprockets::Helpers.configure do |config|
      config.environment = settings.sprockets
      config.prefix      = settings.sprockets_prefix
      config.public_path = '/public'
    end

    Sprockets::Sass.add_sass_functions = true

    sprockets.append_path './assets'

    set :haml, { format: :html5 }
    set :views, './views'
  end

  configure :development do
    register Sinatra::Reloader

    Sprockets::Helpers.configure do |config|
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug = true
    end
  end

  get '/' do
    @title = 'Index'
    slim :index
  end
end
