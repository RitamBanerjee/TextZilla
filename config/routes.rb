Rails.application.routes.draw do
  resources :messages, only: [:create, :update]

  match "/messages/:id/number=:number" => "messages#update", via: :post
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
