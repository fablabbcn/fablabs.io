class ApiLabsSerializer   < ApiV2Serializer
    
 
    link :self do |object|
        "/2/labs/#{object.id}"
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
    #:employees,
    # links_attributes: [ :id, :link_id, :url, '_destroy' ],
    #employees_attributes: [ :id, :job_title, :description ]
  
    # has_many :employees, serializer: EmployeeSerializer
    has_many :links, serializer: ApiLinkSerializer
    has_many :machines, serializer: ApiMachineSerializer
  
    attribute :url do | object |
        # url_for(controller: Api::V2::LabsController, action: :show, id:  object.id)
        "/2/labs/#{object.id}"   
    end

    attribute :avatar_url do | object |
      # Only return url if there is an actual avatar (no default image needed in api)
      if object.avatar_uid.present?
        object.avatar.thumb('150x150#').url(host: 'https://www.fablabs.io')
      end
    end
  
    attribute :header_url do | object |
      # Only return url if there is an actual header (no default image needed in api)
      if object.header.present?
        object.header.thumb("800x").url(host: 'https://www.fablabs.io')
      end
    end
  
  end
