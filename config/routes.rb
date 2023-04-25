Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "cars#index"
  get '/admin' => "admins#index", as: 'admin'
  get '/download_pdf' => "cars#download_pdf", as: 'cars_download_pdf'
  get '/destroy' => "logins#destroy", as: 'logins_destroy'
  get '/:reset' => "cars#index", as: 'reset'
  resources :logins
  resources :cars do
    collection do
      get 'search'
    end
  end
  resources :users
end
