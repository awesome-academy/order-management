Rails.application.routes.draw do
  root to: "home_pages#home"
  
  scope "(:locale)", locale: /en|vi/ do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :products
    resources :combo_products
    resources :combos, except: [:change_combo_status]
    resources :tables
    resources :bills
    resources :bill_details
    resources :bills do
      resources :bill_details
    end
    get "/payment", to: "bills#payment"
    get "/list_bill", to: "bills#list_bill"
  end
end
