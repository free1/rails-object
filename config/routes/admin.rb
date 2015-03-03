namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard
  resources :categories
end	