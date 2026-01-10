class ApiV2Serializer
    include Rails.application.routes.url_helpers
    include JSONAPI::Serializer
end
