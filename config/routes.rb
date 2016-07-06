Rails.application.routes.draw do

  resources :questions

  resources :answers, except: [:show]


  get '/comments/questions-comments' => 'comments_controller#new_question_comment'

  post '/comments/question-comments' => 'comments_controller#create_question_comment'

  get '/comments/answer-comments' => 'comments_controller#new_answer_comment'

  post '/comments/question-comments' => 'comments_controller#create_answer_comment'


  resources :tags, only: [:index, :show]


  post '/questions/:id/upvote' => 'votes_controller#create_question_upvote'
  post '/questions/:id/downvote' => 'votes_controller#create_question_downvote'

  post '/answers/:id/upvote' => 'votes_controller#create_answer_upvote'
  post '/answers/:id/downvote' => 'votes_controller#create_answer_downvote'

  resources :users


  get 'login'  => 'sessions#new' 
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'questions#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
