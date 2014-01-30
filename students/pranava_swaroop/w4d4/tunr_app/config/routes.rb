TunrApp::Application.routes.draw do
  
   root "static_pages#index"


   resources :artists,{shallow: true} do
	   	resources :songs
	   	resources :albums
   end

   resources :albums,{shallow: true} do
   		resources :songs
   end

   resources :songs
   #resources :playlists

   resources :playlists do
    member do
      post 'songs', :to => "playlists#add_song", :as => :add_song_to
    end
  end



  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
