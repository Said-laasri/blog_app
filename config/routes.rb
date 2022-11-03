Rails.application.routes.draw do
  # devise_for :users, sign_out_via: [:get, :post]
  # get 'likes/create'
  # get 'comments/create'
  devise_for :users,
               controllers: {
                   sessions: 'users/sessions',
                   registrations: 'users/registrations'
               }
    get '/member-data', to: 'members#show'


  resources :users do 
    resources :posts 
  end 
  resources :posts do
     resources :comments 
     resources :likes 
  end
  root to: "users#index"
end