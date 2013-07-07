require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'
require 'sass'
require 'coffee-script'
require 'sinatra/sass_sourcemap'

class Workbench < Sinatra::Base
  configure :development, :test do
    register Sinatra::Reloader
    helpers Sinatra::SassSourcemap
  end

  get '/' do
    @title = 'Index'
    slim :index
  end

  get '/css/application.css' do
    sass_map_header :application
    sass_with_map :application
  end

  get '/css/application.sassmap' do
    halt 404, "Not Found\n" if settings.production?
    sass_map :application
  end

  get '/js/application.js' do
    coffee :application
  end
end
