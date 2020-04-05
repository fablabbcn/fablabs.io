Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  # lookup: :google,            # name of geocoding service (symbol)
  #lookup: :nominatim,
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
  #google: { api_key: ENV['GOOGLE_MAPS_API_KEY'], },
  nominatim: {
    http_headers: { "User-Agent" => "fablabs.io" },
  },
)

if Rails.env.test?
  Geocoder.configure(lookup: :test)

  Geocoder::Lookup::Test.add_stub(
    "liverpool", [
      {
        'coordinates'  => [53.409532, -2.983575],
        'address'      => 'Liverpool',
        'state'        => 'gb',
        'state_code'   => 'gb',
        'country'      => 'United Kingdom',
        'country_code' => 'gb'
      }
    ]
  )

  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'coordinates'  => [44.99999, -66.99999],
        'address'      => 'TEST New York, NY, USA',
        'state'        => 'TEST New York',
        'state_code'   => 'NY',
        'country'      => 'TEST United States',
        'country_code' => 'US'
      }
    ]
  )

end
