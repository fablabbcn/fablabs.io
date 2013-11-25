class LabSerializer < ActiveModel::Serializer

  # cached

  attributes :id, :name, :url, :formatted_address, :latitude, :longitude, :country_code, :phone, :email

  def url
    lab_url(object)
  end

  # def cache_key
  #   [object, current_user]
  # end

end
