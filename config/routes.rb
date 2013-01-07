DueIt::Application.routes.draw do
  root to: 'tasks#index'

  resources :projects do
    resources :tasks
  end

  get '/tasks' => 'tasks#index', as: 'all_tasks'
  get '/tasks/this-week' => 'tasks#this_week', as: 'tasks_this_week'
  get '/tasks/next-week' => 'tasks#next_week', as: 'tasks_next_week'
  get '/tasks/this-month' => 'tasks#this_month', as: 'tasks_this_month'
end
