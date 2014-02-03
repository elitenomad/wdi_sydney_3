TunrApp::Application.routes.draw do
  
   root "static_pages#index"


   resources :artists,{shallow: true} do
	   	resources :songs
	   	resources :albums
   end

   resources :albums,{shallow: true} do
   		resources :songs
   end

   resources :songs #, only: [:index]
   #resources :playlists

   resources :playlists 



  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  #get ":action" => "static_pages#:action"
end
