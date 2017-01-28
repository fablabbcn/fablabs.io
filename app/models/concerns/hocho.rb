module Hocho
  def self.hocho(img, options)
    return if img.blank?
    url = "https://davinci.fablabs.io"
    options = options.unpack('H*').first
    img = URI::encode(img)
    img = img.unpack('H*').first
    sig = Digest::SHA1.hexdigest("#{options}#{img}#{ENV['HOCHO_SALT']}")
    [url, options, img, sig].join('/')
  end
end
