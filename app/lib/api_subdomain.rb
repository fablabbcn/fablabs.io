class ApiSubdomain
    def self.matches? request
       case request.subdomain
    		when 'api'
          ApiDeprecationLogger.log(request)

          	  return true
                when 'api.staging'
                  return true
       		else
          	  return false
       		end
    end
end
