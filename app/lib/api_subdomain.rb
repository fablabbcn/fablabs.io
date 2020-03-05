class ApiSubdomain
    def self.matches? request
       case request.subdomain
    		when 'api'
          	  return true
                when 'api.staging'
                  return true
       		else
          	  return false
       		end
    end
end
