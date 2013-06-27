require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'
require 'sass'
require 'coffee-script'

class Workbench < Sinatra::Base
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
