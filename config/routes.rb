Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: %i[index create show update destroy]
  resources :customers, only: %i[create show update] do
    resources :credit_cards, only: %i[index create show update destroy]
  end
end
