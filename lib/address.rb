require_relative 'geocoding'

class Address < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord

  attr_accessor :latitude, :longitude, :full_address

  # call geocode for address lookup
  reverse_geocoded_by :latitude, :longitude

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

  def reverse_geocoded_by
    "#{street}, #{city}, #{state}, #{zipcode}, #{country}"
  end
end
