
class ApiMapSerializer < ApiV2Serializer

    set_type :lab 

  attributes :id,
  :name,
  :slug,
  :latitude,
  :longitude,
  :url


    attribute :url do | object |
        "/2/labs/#{object.id}"
        # Rails.application.routes.url_helpers.api_v2_labs_url(object, :version => 2)
    end


end