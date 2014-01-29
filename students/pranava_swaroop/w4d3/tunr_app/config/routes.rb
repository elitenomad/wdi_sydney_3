TunrApp::Application.routes.draw do
  
  get "static_pages/index"
  get "static_pages/about"
  get "static_pages/contact"
  resources :songs

  resources :albums

  root "application#index"

  resources :artists

 
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
