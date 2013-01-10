DueIt::Application.routes.draw do
  root to: 'tasks#index'

  match '/tasks' => 'tasks#index', as: 'all_tasks'
  match '/tasks/today' => 'tasks#due_today', as: 'tasks_today'
  match '/tasks/this-week' => 'tasks#due_this_week', as: 'tasks_this_week'
  match '/tasks/this-month' => 'tasks#due_this_month', as: 'tasks_this_month'
  match '/tasks/overdue' => 'tasks#overdue', as: 'tasks_overdue'
  match '/projects/:project_id/tasks/:id/complete' => 'tasks#complete', via: :put, as: 'complete_task'
  match '/projects/:project_id/tasks/completed' => 'tasks#completed', via: :get, as: 'completed_tasks'

  resources :projects do
    resources :tasks
  end
end
