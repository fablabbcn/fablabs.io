class WWWSubdomain
    def self.matches? request
       if request.subdomain
          case request.subdomains[0]
          when 'api'
             return false
          when 'api.staging'
	     return false
	  else
             return true
          end
       else
          return true
       end
    end
end
