Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root   'application#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    '/questions/upvote/:question_id'   => 'questions#upvote'
  get    '/questions/downvote/:question_id' => 'questions#downvote'
  get    '/answers/upvote/:answer_id'       => 'answers#upvote'
  get    '/answers/downvote/:answer_id'     => 'answers#downvote'
  
  patch  '/question/:question_id/answers/:answer_id/accept'       => 'answers#accept'

  resources :users
  resources :comments, only: [:create, :destroy]
  
  resources :questions do 
  	resources :answers
  end

  resources :categories

end
