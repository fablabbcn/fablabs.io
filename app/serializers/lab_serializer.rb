class LabSerializer < ActiveModel::Serializer

  cached

  attributes :id, :name, :url, :latitude, :longitude, :country_code

  def url
    lab_url(object)
  end

  def cache_key
    [object, current_user]
  end

end
