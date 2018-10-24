require 'sinatra/base'
require 'active_record'
Dir['./lib/*.rb'].each { |f| require f }

enable :sessions

class Main < Sinatra::Base
  Coordinate.establish_connection(
      :adapter => "sqlite3",
      :database => "locations.db"
  )

  get '/' do

    @addresses = []
    @coordinates = Coordinate.all()
    @coordinates.each do |obj|
      puts obj.latitude, obj.longitude

      #address = reverse_geocode(obj.latitude, obj.longitude) do
      #@addresses <<
    end

    erb :index, locals: { coordinates: @coordinates } #, addresses: @addresses }
  end

  get '/addresses' do

    @coordinates = Coordinate.all()
    @coordinates.each do |obj|
      puts obj.latitude, obj.longitude

      #address = reverse_geocode(obj.latitude, obj.longitude) do
      #@addresses <<
    end

    erb :addresses, locals: { coordinates: @coordinates }
  end

end
