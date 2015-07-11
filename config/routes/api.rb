namespace :new_api, defaults: {format: 'json'} do

	namespace :v2 do
	  resources :home
	end
	
end
