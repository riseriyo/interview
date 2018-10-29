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

      addr = Address::WithAddress.create(id:        6,
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
        puts "WHITE HOUSE SAVED!!"
      end
      if addr.geocoded?
        puts "WHITE HOUSE GEOCODED!!!"
      end

      coord_dict.each_with_index do |obj|
        #binding.pry
        addr = Address::WithLatLng.create(id:        obj[0],
                                          street:    nil,
                                          city:      nil,
                                          state:     nil,
                                          zipcode:   nil,
                                          country:   nil,
                                          latitude:  obj[1][0],
                                          longitude: obj[1][1],
                                          distance:  nil
        )

        if addr.valid?
          p addr
          puts "Address Saved!!!"
        end

        @whitehouse = Address.find(6)
        distance = addr.distance_from([@whitehouse[:latitude], @whitehouse[:longitude]])

        #binding.pry
        puts ">>>>>>> #{distance} "
        addr.distance = distance
        addr.save

      end
    end
  end

  before '/' do
    geocoders(COORD_DICT)
  end

  get '/' do

    target_text = "1600 Pennsylvania Avenue NW Washington, D.C. 20500"

    sleep(3.seconds)
    @whitehouse = Address.find(6)
    erb :index, locals: { locations: COORD_DICT,
                          target: @whitehouse.address,
                          target_coord: @whitehouse}
    #binding.pry

  end

  get '/addresses' do

    @whitehouse = Address.find(6)
    #binding.pry
    @addresses = Address.all

    @addresses.each do |obj|
      puts obj.latitude
      puts obj.longitude
    end

    erb :addresses, locals: { addresses: @addresses }
  end

end