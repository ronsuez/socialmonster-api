
module API
	class Base < Grape::API
		
		before do
    	header "Access-Control-Allow-Origin", "*"
  	end
		prefix 'api'
		version 'v1', using: :path
		mount API::Employee 
		mount API::Post
	
	 	add_swagger_documentation(
      base_path: "",
      api_version: "v1",
      hide_documentation_path: true
    )
	end
end