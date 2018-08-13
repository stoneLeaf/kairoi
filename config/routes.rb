Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'

  get 'pages/home'
  get 'pages/about'
  get 'pages/tos'
  get 'pages/contact'

end
