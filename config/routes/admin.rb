namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard
end