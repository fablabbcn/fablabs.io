return unless File.exist?('BANNED_IPS.txt')

BANNED_IPS = File.readlines('BANNED_IPS.txt', chomp: true)

puts "---- Rack::Attack Blocking #{BANNED_IPS.length} IPs"

Rack::Attack.blocklist('block multiple IPS') do |req|
  BANNED_IPS.include?(req.ip)
end

Rack::Attack.blocklisted_response = lambda do |_env|
  [503, {}, ['Your IP has been blocked because your IP has been trying to abuse the website.']]
end
