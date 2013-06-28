require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'
require 'sass'
require 'compass'
require 'coffee-script'

class Workbench < Sinatra::Base
  configure do
    Compass.configuration do |config|
      config.project_path = File.dirname(__FILE__)
      config.sass_dir = 'views'
    end

    set :haml, { format: :html5 }
    set :sass, Compass.sass_engine_options
    set :scss, Compass.sass_engine_options
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @title = 'Index'
    slim :index
  end

  get '/css/application.css' do
    content_type 'text/css'
    sass :application
  end

  get '/js/application.js' do
    coffee :application
  end
end
