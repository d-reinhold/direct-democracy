AllocationsPrototype::Application.routes.draw do
  get 'bills' => 'bills#index'
  get 'tags' => 'tags#index'
  get 'votes' => 'votes#index'
  get 'citizens/:id' => 'citizens#show'
  get 'reps/:id' => 'reps#show'
  put 'citizens/:id' => 'citizens#update'
  put 'bills/:id' => 'bills#update'
  post 'votes/' => 'votes#create'
  get 'bills/events' => 'bills#events'
  root to: 'index#main'
end
