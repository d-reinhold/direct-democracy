AllocationsPrototype::Application.routes.draw do
  get 'bills' => 'bills#index'
  get 'tags' => 'tags#index'
  get 'citizens/:id' => 'citizens#show'
  put 'citizens/:id' => 'citizens#update'
  get 'rep/:id' => 'reps#show'
  put 'bills/' => 'bills#update'
  post 'bills/' => 'bills#create'
  get 'bills/events' => 'bills#events'
  root to: 'index#main'
end
