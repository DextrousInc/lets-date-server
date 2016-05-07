Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'users#home'
  get 'users' => 'users#list'
  get 'users/date' => 'users#date_list'

  post 'users/new' => 'users#create'
  get 'users/new' => 'users#new'

  post 'users/login' => 'users#login'
  get 'users/login' => 'users#view_login'

  get 'users/logout' => 'users#logout'

  get 'users/view/:id' => 'user_interests#show'

  post 'users/interests/new' => 'user_interests#create'
  get 'users/interests/new' => 'user_interests#new'

  get 'users/interests/impress' => 'user_interests#impress'

  #api
  #namespace :api do
    # resources :user, only: [:index, :create, :show, :update, :destroy]
    get 'api/users/view/:id' => 'api/users#show'
    get 'api/users/all' => 'api/users#list'

    get 'api/dates/all/:id' => 'api/users#date_list'

    post 'api/users/login' => 'api/users#login'

    get 'api/users/interests/all/:id' => 'api/user_interests#list'
    get 'api/users/interests/impress/:id/:category' => 'api/user_interests#impress'

    # resources :microposts, only: [:index, :create, :show, :update, :destroy]
  #end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
