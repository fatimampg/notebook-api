Rails.application.routes.draw do
  # mount_devise_token_auth_for "User", at: "auth"
  resources :kinds
  resource :auths, only: [ :create ]

  resources :contacts do
    resource :kind, only: [ :show ]
    resource :kind, only: [ :show ], path: "relashionships/kind"

    resource :phones, only: [ :show ]
    resource :phones, only: [ :show ], path: "relashionships/phones"

    resource :phone, only: [ :update, :create, :destroy ]
    resource :phone, only: [ :update, :create, :destroy ], path: "relashionships/phones"

    resource :address, only: [ :show, :update, :create, :destroy ]
    resource :address, only: [ :show, :update, :create, :destroy ], path: "relashionships/address"
  end

  # get "/contacts", to: "contacts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
