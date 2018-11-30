class ApiProjectSerializer < ApiV2Serializer
    attributes :id, :title, :owner, :lab, :project_cover
    set_type :project

    has_many :collaborators
    has_many :links
    has_many :contributors
 
    link :self do |object|
        "/v2/projects/#{object.id}"
    end


end