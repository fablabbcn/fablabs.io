class ImageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true unless record.changes.keys.include?(attribute)

    uri = URI(Hocho.hocho(value, 'o=t&q=80&d=300x300&'))
    Net::HTTP.start(uri.host) do |http|
      response = http.head(uri.path)
      if response.code != "200"
        record.errors.add(attribute, :invalid)
      end
    end
  end
end

