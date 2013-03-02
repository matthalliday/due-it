DueIt::Application.routes.draw do
  root to: 'tasks#index'

  get '/tasks' => 'tasks#index', as: 'all_tasks'
  get '/tasks/today' => 'tasks#due_today', as: 'tasks_today'
  get '/tasks/this-week' => 'tasks#due_this_week', as: 'tasks_this_week'
  get '/tasks/this-month' => 'tasks#due_this_month', as: 'tasks_this_month'
  get '/tasks/overdue' => 'tasks#overdue', as: 'tasks_overdue'
  put '/projects/:project_id/tasks/:id/complete' => 'tasks#mark_complete', as: 'mark_task_complete'
  put '/projects/:project_id/tasks/:id/incomplete' => 'tasks#mark_incomplete', as: 'mark_task_incomplete'
  get '/projects/:project_id/tasks/completed' => 'tasks#completed', as: 'completed_tasks'
  get '/log-out' => 'sessions#destroy', as: 'log_out'
  get '/log-in' => 'sessions#new', as: 'log_in'
  get '/sign-up' => 'users#new', as: 'sign_up'
  get '/users/:id/activate' => 'users#activate'

  resources :users
  resources :sessions
  resources :password_resets
  resources :projects do
    resources :tasks
  end
end
