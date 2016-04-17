namespace :new_api, defaults: {format: 'json'} do

  namespace :v2 do
    resources :home
    resources :products
    resources :search do
      collection do
        get :product_search
      end
    end
    resources :categories
  end

end
