Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'welcome/index'

  get 'pages/aboutus'
  get 'pages/contactus'
  get 'pages/professionalservices'
  get 'pages/products'
  get 'pages/solutions'
  get 'pages/pricing'
  get 'pages/pvm'
  get 'pages/wso2is'
  get 'pages/jira'

#  root :to => redirect('/')
  root :to => 'welcome#index'
  devise_for :users
  resources :pvprovisions
  resources :pvcrequests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
