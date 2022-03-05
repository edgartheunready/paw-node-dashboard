Rails.application.routes.draw do
  resources :accounts do
    collection do
      get :trends
    end
    resources :account_transactions do
    end
  end
  resources :account_transactions do
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
