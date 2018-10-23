require_relative 'geocoding'

class Address

  attr_accessor :latitude, :longitude, :full_address

  # call geocode for address lookup
  #reverse_geocoded_by :latitude, :longitude

  #after_validation :reverse_geocode

  def self.reverse_geocode
    return :full_address
  end
end
