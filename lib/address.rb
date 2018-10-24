require_relative 'geocoding'

class Address < ActiveRecord::Base
  #extend Geocoder::Model::ActiveRecord

  attr_accessor :latitude, :longitude, :full_address

  # call geocode for address lookup
  #reverse_geocoded_by :latitude, :longitude, address: :full_address do |obj,results|
  #  if geo = results.first
  #    obj.street    = geo.address
  #    obj.city      = geo.city
  #    obj.state     = geo.state
  #    obj.zipcode   = geo.postal_code
  #    obj.country   = geo.country
  #  end
  #end

  after_validation :reverse_geocode

  def initialize

  end

  def new

  end

  def self.reverse_geocode(lat,long)
    #reverse_geocoded_by(lat,long)
  end

end
