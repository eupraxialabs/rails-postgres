Rails.application.routes.draw do
  get 'welcome/index'

  get 'pages/aboutus'
  get 'pages/contactus'
  get 'pages/professionalservices'
  get 'pages/products'
  get 'pages/services'
  get 'pages/pricing'
  get 'pages/pvm'

#  root :to => redirect('/')
  root :to => 'welcome#index'
  devise_for :users
  resources :pvprovisions
  resources :pvcrequests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
