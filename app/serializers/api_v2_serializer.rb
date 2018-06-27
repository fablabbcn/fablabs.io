class ApiV2Serializer

    include Rails.application.routes.url_helpers
    include FastJsonapi::ObjectSerializer
    
end
