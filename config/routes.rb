Rails.application.routes.draw do

  root 'general#home'

  get 'pages/home'
  get 'pages/about'
  get 'pages/tos'
  get 'pages/contact'
  
end
