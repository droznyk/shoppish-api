Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: %i[index create show update destroy]
  resources :customers, only: %i[create show update] do
    resources :credit_cards, only: %i[index create show destroy]
  end

  resources :orders, only: %i[index show destroy]
  post '/order/step1', to: 'orders#form_step1'
  post '/order/step2', to: 'orders#form_step2'
  post '/order/step3', to: 'orders#form_step3'
end
