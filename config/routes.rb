Vle::Application.routes.draw do
  resources :blocks

  resources :divisions

  resources :districts

  resources :users  do
    get :confirm,:on=>:collection
    post :verification,:on=>:collection
  end

  # root :to => "welcome#index"
  # match ':controller(/:action(/:id(.:format)))'
end
