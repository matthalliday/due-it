TestApp::Application.routes.draw do
  resources :projects do
    resources :tasks
  end
  resources :tasks, only: :index

  root to: 'tasks#index'
end
