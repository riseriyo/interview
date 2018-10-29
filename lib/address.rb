require_relative 'geocoding'

class Address < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord

  # call geocode for address lookup and coordinates lookup
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.street   = geo.address.split(',')[0]
      obj.city     = geo.city
      obj.state    = geo.state
      obj.zipcode  = geo.postal_code
      obj.country  = geo.country
    end
  end

  def address
    [street,city,state,zipcode,country].join(',')
  end
end

class Address::WithAddress < Address
  after_validation :geocode
end

class Address::WithLatLng < Address
  after_validation :reverse_geocode
end