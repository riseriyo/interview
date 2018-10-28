require_relative 'geocoding'

class Address < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord

  # call geocode for address lookup and coordinates lookup
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.id      = id
      obj.street  = geo.address
      obj.city    = geo.city
      obj.state   = geo.state
      obj.zipcode = geo.zipcode
      obj.country = geo.country
    end
  end

  after_validation :geocode, :reverse_geocode #, :if => :address_changed?

  def address
    [street,city,state,zipcode,country].join(',')
  end

  def latitude
  end

  def longitude
  end
end
