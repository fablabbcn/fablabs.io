class ApiLinkSerializer   < ApiV2Serializer

    set_type :link
     
    link :self do |object|
        "/2/links/#{object.id}"
    end

    attributes :id, :url

end
