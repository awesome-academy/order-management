Rails.application.routes.draw do
  root to: "home_pages#home"
  
  scope "(:locale)", locale: /en|vi/ do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :products
    resources :combo_products
    resources :combos
  end
end
