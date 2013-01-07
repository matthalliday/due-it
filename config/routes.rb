DueIt::Application.routes.draw do
  root to: 'tasks#index'

  resources :projects do
    resources :tasks
  end

  get '/tasks' => 'tasks#index', as: 'all_tasks'
end
