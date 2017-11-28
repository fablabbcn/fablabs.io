Timezone::Lookup.config(:geonames) do |c|
  c.username = ENV['GEONAMES_USERNAME'] || "guest"
end
