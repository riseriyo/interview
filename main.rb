require 'sinatra'
require 'sinatra/activerecord'


Dir['./lib/*.rb'].each { |f| require f }

enable :sessions

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "locations.db"
)

class Main < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do

    @addresses = []

    @coordinates = Coordinate.all()
    @coordinates.each do |obj|
      puts obj.latitude, obj.longitude
      results = Geocoder.search([obj.latitude, obj.longitude])
      puts results.first
      @addresses << results
    end

    erb :index, locals: { coordinates: @coordinates }
  end

  get '/addresses' do

    @coordinates = Coordinate.all()
    @coordinates.each do |obj|
      puts obj.latitude, obj.longitude

      #address = reverse_geocode(obj.latitude, obj.longitude) do
      #@addresses <<
    end

    erb :addresses, locals: { coordinates: @coordinates, addresses: "address_placeholder" }
  end

end