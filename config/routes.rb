TestApp::Application.routes.draw do
  resources :projects do
    resources :tasks
  end

  root to: 'tasks#index'
end
