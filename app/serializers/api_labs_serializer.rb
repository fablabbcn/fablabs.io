class ApiLabsSerializer   < ApiV2Serializer
    
 
    link :self do |object|
        "/v2/labs/#{object.id}"
    end

    set_type :lab
   
    attributes :id,
    :name,
    :parent_id,
    :blurb,
    :description,
    :slug,
    :address_1,
    :address_2,
    :city,
    :county,
    :postal_code,
    :country_code,
    :latitude,
    :longitude,
    :address_notes,
    :phone,
    :email,
    :capabilities
    # :links,
    # :employees
    # links_attributes: [ :id, :link_id, :url, '_destroy' ],
    # employees_attributes: [ :id, :job_title, :description ]
  
    has_many :links
    has_many :machines, serializer: ApiMachineSerializer
  
    attribute :kind_name do | object |
      Lab::Kinds[object.kind]
    end
  
    attribute :url do | object |
        # url_for(controller: Api::V2::LabsController, action: :show, id:  object.id)
        "/2/labs/#{object.id}"   
    end
  
    attribute :avatar_url do | object |
      if object.avatar_uid.present?
        Dragonfly.app.remote_url_for(object.avatar_uid)
      end
    end
  
    attribute :header_url do | object |
      if object.header.present?
        Dragonfly.app.remote_url_for(object.header_uid)
      end
    end
  
  end