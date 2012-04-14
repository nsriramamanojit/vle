Vle::Application.routes.draw do
  resources :panchayats

  resources :blocks

  resources :divisions

  resources :districts

  resources :users  do
    get :confirm,:on=>:collection
    post :verification,:on=>:collection
    get :export,:on=>:collection
    get :export_csv,:on=>:collection
  end

  # root :to => "welcome#index"
  match ':controller(/:action(/:id(.:format)))'
end
