Rails.application.routes.draw do
  get 'welcome/index'

  get 'pages/aboutus'
  get 'pages/professionalservices'
  get 'pages/products'
  get 'pages/services'

#  root :to => redirect('/')
  root :to => 'welcome#index'
  devise_for :users
  resources :pvprovisions
  resources :pvcrequests
  resources :controller => 'devise/registration', :action => 'new'
  resources :controller => 'sessions', :action =>  'new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
