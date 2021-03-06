# frozen_string_literal: true

Rails.application.routes.draw do

  authenticated :user do
    root to: "dashboards#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home"
  end

  devise_for :users, skip: [:sessions]
  devise_scope :user do
    get '/login' => 'devise/sessions#new', as: :new_user_session
    post '/login' => 'devise/sessions#create', as: :user_session
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  get '/features' => 'pages#features'
  get '/about' => 'pages#about'
  get '/tos' => 'pages#tos'
  get '/contact' => 'pages#contact'

  resources :projects, param: 'project_namespace/:project_slug'
  resources :records, only: %i[create destroy]
  get '/records/stop' => 'records#stop', as: :stop_record

end
