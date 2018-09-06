Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root   'home#index'
  patch  '/question/:question_id/answers/:id/accept' => 'answers#accept'

  post '/votes/update'   => 'votes#update'
  
  resources :users
  resources :comments, only: :destroy
  
  resources :questions do 
    resources :comments, only: :create
  	
    resources :answers, except: [:index] do
      resources :comments, only: :create
    end
  end

  resources :categories, only: [:index]

end
