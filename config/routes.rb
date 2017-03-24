Rails.application.routes.draw do

  root "welcome#index"
  # get '/' => "welcome#index", as: 'root'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :listings, controller: "listings", only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :users, controller: "users", only: [:index, :show, :destroy, :edit, :update, :create] do
    resource :password, # user can only have one password therefor resource without a s
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings # user can have a lot of lisitings therefore resources with a s
  end



  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
