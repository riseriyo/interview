require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

#require 'yaml/store'

class Main < Sinatra::Base


  get '/' do
    erb :index #, locals: { address: address }
  end

  post '/addresses' do
    # {coordinate => [address,distance]}
    @v = []
    @params = params

    #params.keys.each do | k |
      #puts k
      #@result = Geocoder.reverse_geocode(@params[k])
      #@v << @result
    #end
    erb :addresses
  end

end
