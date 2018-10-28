require 'bundler/setup'

Bundler.require

configure :development do
    set :database, 'sqlite3:db/locations.db'
end

require 'dotenv'
Dotenv.load
#GEOCODIO_API_KEY = ENV["GEOCODIO_API_KEY"]
GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"]

require './main'
run Main
