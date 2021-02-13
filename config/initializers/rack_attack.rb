BANNED_IPS = %w[
  3.6.145.177
  36.74.42.89
  36.74.47.177
  36.75.80.195
  36.78.20.131
  36.81.240.106
  37.120.151.107
  37.130.224.22
  114.5.217.66
  114.122.70.56
  178.162.222.161
  223.185.42.72
  223.185.17.90
]

Rack::Attack.blocklist('block multiple IPS') do |req|
  BANNED_IPS.include?(req.ip)
end

Rack::Attack.blocklisted_response = lambda do |_env|
  [503, {}, ['Your IP has been blocked because your IP has been trying to abuse the website.']]
end
