require 'bundler/setup'

Bundler.require

configure :development do
    set :database, 'sqlite3:db/locations.db'
end

require './main'
run Main
