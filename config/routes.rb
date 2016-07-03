Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :projects do
    resources :tasks
  end

  get "/sign-in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign-out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign-up" => "clearance/users#new", as: "sign_up"
  get '/tasks' => 'tasks#index', as: 'all_tasks'
  get '/tasks/today' => 'tasks#due_today', as: 'tasks_today'
  get '/tasks/upcoming' => 'tasks#upcoming', as: 'tasks_upcoming'
  get '/tasks/overdue' => 'tasks#overdue', as: 'tasks_overdue'
  put '/projects/:project_id/tasks/:id/complete' => 'tasks#mark_complete', as: 'mark_task_complete'
  put '/projects/:project_id/tasks/:id/incomplete' => 'tasks#mark_incomplete', as: 'mark_task_incomplete'
  get '/projects/:project_id/tasks/completed' => 'tasks#completed', as: 'completed_tasks'
end
