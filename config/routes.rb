Rails.application.routes.draw do
  resources :products

  resources :orders

  resource :cart, only:[:show, :destroy] do
    member do
      post :add, path: 'add/:id'
    end

    collection do
      get :checkout
    end
  end
end
