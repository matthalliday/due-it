DueIt::Application.routes.draw do
  root to: 'tasks#index'

  resources :projects do
    resources :tasks
  end

  match '/tasks' => 'tasks#index', as: 'all_tasks'
  match '/tasks/this-week' => 'tasks#this_week', as: 'tasks_this_week'
  match '/tasks/next-week' => 'tasks#next_week', as: 'tasks_next_week'
  match '/tasks/this-month' => 'tasks#this_month', as: 'tasks_this_month'
  match '/projects/:project_id/tasks/:id/complete' => 'tasks#complete', via: :put, as: 'complete_task'
end
