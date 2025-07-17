Rails.application.routes.draw do
  devise_for :users
  get 'reservations/new'
  get 'reservations/create'
  get 'inquiries/new'
  get 'inquiries/create'
  resources :news
  get 'reviews' =>'reviews#index'
  #get 'reviews/index'
  get 'reviews/new' =>'reviews#new'
  #get 'reviews/create'
  post 'reviews/create' =>'reviews#create'
  
  get 'orders/new'
  get 'orders/create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check


  #get 'tweets/index' => 'tweets#index'
  get 'tweets/top' => 'tweets#top'

  #get 'vision_and_products', to: 'tweets#vision_and_products'

  resources :tweets do
    resources :orders, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
    resources :news, only: [:index, :new, :create, :show]
  end

  resources :inquiries, only: [:new, :create]
  resources :reservations, only: [:new, :create]


  root 'tweets#top'
  

  # Defines the root path route ("/")
  # root "posts#index"
  
end
