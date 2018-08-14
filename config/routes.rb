Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root to: "dashboards#show", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home"
  end

  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/sign_up' => 'devise/registrations#new'
  end

  get '/features' => 'pages#features'
  get '/about' => 'pages#about'
  get '/tos' => 'pages#tos'
  get '/contact' => 'pages#contact'

end
