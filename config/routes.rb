Rails.application.routes.draw do
#  get 'users/index'

#  get 'users/show'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  #resources :users, only: [:index, :show]
  resources :users
  get 'inquiries' => 'inquiries#index'
  post 'inquiries' => 'inquiries#index'
#  post 'inquiries/create' => 'inquiries#create'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/thanks' => 'inquiries#thanks'
#  root 'top#index'
  root to: "top#index"
  resources :blogs
end

