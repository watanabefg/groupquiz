Groupquiz::Application.routes.draw do
  get "users/index"
  get "users/callback"
  get "users/edit"

  get "pages/home"
  get "pages/features"
  get "pages/plans"

  get "sessions/create"

  get "groups/ordergroup"
  get "groups/orderowner"
  get "groups/orderupdated"
  get "groups/confirm"
  get "groups/error"

  get "quizzes/import"
  post "quizzes/import" => "quizzes#upload"

  root :to => "users#index"
  match "/signin" => "sessions#new", :as => :signin
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout  
  match "/features" => "pages#features"
  match "/plans" => "pages#plans"
  resources :quizzes
  resources :users
  resources :groups
  resources :categories
  resources :answers
  match "groups/:id/dropout", :to => "groups#dropout", :as => :dropout_group
  match "groups/:id/dropin", :to => "groups#dropin", :as => :dropin
  match "groups/:id/checkout", :to => "groups#checkout", :as => :checkout_group
  match "groups/complete", :to => "groups#complete"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
