Rails.application.routes.draw do
  devise_for :users
  # get 'likes/create'
  # get 'comments/create'
  resources :users do 
    resources :posts 
  end 
  resources :posts do
     resources :comments 
     resources :likes 
  end
  root to: "users#index"
end
