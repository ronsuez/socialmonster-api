module API
	class Employee < Grape::API
		  use Rack::JSONP
			
			resource :employee_data do
					desc "List all Employee"

					get do
						EmpDatum.all
					end

					desc "list an employee"

					get ':id' do
						EmpDatum.find(params[:id])
					end

					desc "create a new employee"

					params do
						requires :name, type: String
						requires :address, type: String
						requires :age, type: Integer
					end	

					post do
						  EmpDatum.create!({
						    name:params[:name],
						    address:params[:address],
						    age:params[:age]
						  })
					end

					desc "delete an employee"

					params do
						requires :id, type: String
					end

					delete ':id' do
						EmpDatum.find(params[:id]).destroy!
					end

					desc "update an employee address"

					params do
						requires :id, type: String
						requires :address, type: String
					end	

					put ':id' do
						  EmpDatum.find(params[:id]).update({
						  	address: params[:address]
						  })
					end

			end
	end
end