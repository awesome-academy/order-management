Rails.application.routes.draw do
  root to: "home_pages#home"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :products
  resources :combo_products
  resources :combos
  resources :tables
  resources :bills
  resources :bill_details
  resources :bills do
    resources :bill_details
  end
  get "/payment", to: "bills#payment"
  get "/list_bill", to: "bills#list_bill"
  get "/search_table", to: "bills#index"
  get "/search_user", to: "users#index"
  get "/search_table_manager", to: "tables#index"
  get "/search_product", to: "products#index"
  get "/search_combo", to: "combos#index"
  post "/search_table", to: "bills#search_table"
  post "/search_user", to: "users#search_user"
  post "/search_table_manager", to: "tables#search_table"
  post "/search_product", to: "products#search_product"
  post "/search_combo", to: "combos#search_combo"
end
