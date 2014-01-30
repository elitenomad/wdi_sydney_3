TunrApp::Application.routes.draw do
  
   root "application#index"


  resources :songs

  resources :albums

  

  resources :artists

 
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
