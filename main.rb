require 'sinatra'
require 'sinatra/activerecord'


Dir['./lib/*.rb'].each { |f| require f }


ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/locations.db"
)


class Main < Sinatra::Base

  COORD_DICT = {
      1 => [61.582195,-149.443512],
      2 => [44.775211,-68.774184],
      3 => [25.891297,-97.393349],
      4 => [45.787839,-108.502110],
      5 => [35.109937,-89.959983]
  }


  helpers do
    def geocoders( coord_dict )
      coord_dict.each do |key, arr|

        addr = Address.new(       id:        key,
                                  street:    nil,
                                  city:      nil,
                                  state:     nil,
                                  zipcode:   nil,
                                  country:   nil,
                                  latitude:  arr[0],
                                  longitude: arr[1],
                                  distance:  nil
        )
        if addr.valid?
          p addr
          addr.save!
        end

      end

      addr = Address.new(      id:        6,
                               street:    "1600 Pennsylvania Avenue",
                               city:      "NW Washington",
                               state:     "District of Columbia",
                               zipcode:   "20500",
                               country:   "United States",
                               latitude:  nil,
                               longitude: nil,
                               distance:  nil
      )
      if addr.valid?
        p addr
        addr.save!
      end
    end
  end

  before '/' do
    geocoders(COORD_DICT)
  end

  get '/' do

    target = "1600 Pennsylvania Avenue NW Washington, D.C. 20500"

    sleep(3.seconds)
    erb :index, locals: { locations: COORD_DICT, target: target }
    #binding.pry

  end

  get '/addresses' do

    Address.where(:id => params[:id]).order("created_at DESC").offset(1).reverse
    @addresses.each do |obj|
      puts obj.latitude
      puts obj.longitude
    end
    @results = Address.reverse_geocoded_by([61.582195],[-149.443512])

    erb :addresses, locals: { addresses: @addresses, results: @results }
  end

end