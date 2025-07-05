Rails.application.routes.draw do
  get "tasks/index"
  get "tasks/show"
  get "tasks/new"
  get "tasks/create"
  get "tasks/edit"
  get "tasks/update"
  get "tasks/destroy"
  get "categories/index"
  get "categories/show"
  get "categories/new"
  get "categories/create"
  get "categories/edit"
  get "categories/update"
  get "categories/destroy"
  devise_for :users
  get "pages/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#index"
  resources :users do
    resources :categories do
      resources :tasks
    end
  end
end
