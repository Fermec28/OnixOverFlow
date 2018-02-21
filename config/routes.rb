Rails.application.routes.draw do

  scope '/(:locale)', defaults: { locale: 'es' }, constraints: { locale: /en|es/ } do

  root 'questions#index'
  devise_for :users
  resources :questions do
  	resources :answers, except: [:new,:index]
  	resources :comments, except: [:new,:index]
  	resources :votes, only: [:create,:update,:destroy]
  end

  resources :answers do
  	resources :comments, except: [:new,:index]
  	resources :votes, only: [:create,:update,:destroy]
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
