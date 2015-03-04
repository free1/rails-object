namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard
  resources :categories do
  	member do
  		post :change_weight
  	end
  end
end	