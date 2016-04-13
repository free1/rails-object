namespace :new_api, defaults: {format: 'json'} do

  namespace :v2 do
    resources :home
    resources :products
    resources :categories
  end

end
