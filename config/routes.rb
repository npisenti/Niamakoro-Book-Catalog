BookCatalogue::Application.routes.draw do

  resources :authors, :subjects, :class_records

  resources :grades do
    get 'statistics', :on => :member
  end

  resources :books do
    get 'statistics', :on => :member
    get 'title_data', :on => :collection
    get 'popular', :on => :collection
  end

  resources :checkout_items do
    post 'checkin_many', :on => :collection
    post 'batch_checkin', :on => :collection
    post 'batch_checkout', :on => :collection
  end
  
  resources :user_sessions, :only => [ :new, :create, :destroy ]

  match '/batch-checkout', :to => 'pages#batch_checkout', :as => 'batch_checkout'
  match '/batch-checkin', :to => 'pages#batch_checkin', :as => 'batch_checkin'
  match '/search_bar', :to => 'books#search_bar'
  match '/csv', :to => 'books#csv'

  match '/checkout_items/checkin', :to => 'checkout_items#checkin', :as => 'checkin'

  root :to => "pages#home", :as => "home"
  
  match 'admin' => 'pages#admin', :as => "admin"
  match 'stats' => 'pages#stats', :as => "stats"
  match 'class_stats' => 'pages#class_stats', :as => "class_stats"
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
