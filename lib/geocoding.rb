require 'geocoder'

#Geocoder.configure(lookup: :geocoder_ca, timeout: 2)
#Geocoder.configure(lookup: :nominatim, timeout: 2)
#Geocoder.configure(api_key: GEOCODIO_API_KEY, lookup: :geocodio, timeout: 2)
Geocoder.configure(api_key: GOOGLE_API_KEY, lookup: :google, timeout: 25)