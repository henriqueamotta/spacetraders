Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  root to: "pages#home"

  # About us
  get '/about-us', to: 'pages#about', as: 'about_us'

  get "up" => "rails/health#show", as: :rails_health_check

  # Rotas para produtos
  resources :products do
    member do
      delete :delete_photo
    end
  end

  # Rota para categorias filtradas
  get "products/category/:category", to: "products#index", as: :filtered_products

  # Rotas para pedidos
  resources :orders, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :order_confirmation
    end

    collection do
      delete "remove_from_cart/:product_id", to: "orders#remove_from_cart", as: :remove_from_cart
    end
  end

  # Adicionar ao carrinho
  post "cart/:id", to: "products#add_to_cart", as: "add_to_cart"

  # Rota para o dashboard do vendedor
  get "my_products", to: "dashboards#my_products", as: :seller_dashboard
end
