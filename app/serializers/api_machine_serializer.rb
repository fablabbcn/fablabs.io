class ApiMachineSerializer   < ApiV2Serializer
    
    set_type :machine
 
    link :self do |object|
        "/v2/machines/#{object.id}"
    end


    belongs_to :brand, serializer: ApiBrandSerializer

    attributes :id, :name
end