BANNED_IPS_PATH = Rails.root.join("BANNED_IPS.txt")

BANNED_IPS = if File.exist?(BANNED_IPS_PATH)
  Rails.logger.info("[Rack::Attack] BANNED_IPS.txt found")
  File.readlines(BANNED_IPS_PATH).map(&:strip).reject(&:blank?).freeze
else
  Rails.logger.info("[Rack::Attack] BANNED_IPS.txt not found — no IPs will be blocked")
  [].freeze
end

Rack::Attack.blocklist('block multiple IPS') do |req|
  BANNED_IPS.include?(req.ip)
end

Rack::Attack.blocklisted_responder = lambda do |req|
  [503, {}, ['Your IP has been blocked because your IP has been trying to abuse the website.']]
end


### Throttle Spammy Clients ###

# If any single client IP is making tons of requests, then they're
# probably malicious or a poorly-configured scraper. Either way, they
# don't deserve to hog all of the app server's CPU. Cut them off!
#
# Note: If you're serving assets through rack, those requests may be
# counted by rack-attack and this throttle may be activated too
# quickly. If so, enable the condition to exclude them from tracking.

# Throttle all requests by IP (60rpm)
#
# Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
# Rack::Attack.throttle('req/ip', limit: 10, period: 5.minutes) do |req|
#   req.ip # unless req.path.start_with?('/assets')
# end

### Prevent Brute-Force Login Attacks ###

# The most common brute-force login attack is a brute-force password
# attack where an attacker simply tries a large number of emails and
# passwords to see if any credentials match.
#
# Another common method of attack is to use a swarm of computers with
# different IPs to try brute-forcing a password for a specific account.

# Throttle POST requests to /login by IP address
#
# Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
Rack::Attack.throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
  if req.path == '/sessions' && req.post?
    req.ip
  end
end

# Throttle POST requests to /login by email param
#
# Key: "rack::attack:#{Time.now.to_i/:period}:logins/email:#{normalized_email}"
#
# Note: This creates a problem where a malicious user could intentionally
# throttle logins for another user and force their login requests to be
# denied, but that's not very common and shouldn't happen to you. (Knock
# on wood!)
Rack::Attack.throttle('logins/email', limit: 5, period: 20.seconds) do |req|
  if req.path == '/sessions' && req.post?
    # Normalize the email, using the same logic as your authentication process, to
    # protect against rate limit bypasses. Return the normalized email if present, nil otherwise.
    req.params['email_or_username'].to_s.downcase.gsub(/\s+/, "").presence
  end
end

Rack::Attack.throttle('recoveries/ip', limit: 3, period: 2.minutes) do |req|
  if req.path == '/recoveries' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('signups/ip', limit: 10, period: 2.minutes) do |req|
  if req.path == '/users' && req.post?
    req.ip
  end
end

# Log any throttle attacks (help debug if too aggressive)
ActiveSupport::Notifications.subscribe("throttle.rack_attack") do |name, start, finish, request_id, payload|
  req = payload[:request]
  Rails.logger.info "[Rack::Attack] #{req.env['rack.attack.match_type']} for #{req.request_method} #{req.fullpath} from #{req.ip}"
end
