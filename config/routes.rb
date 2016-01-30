Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users
  resources :users, only: [:index, :show]
  get 'inquiries' => 'inquiries#index'
  post 'inquiries' => 'inquiries#index'
#  post 'inquiries/create' => 'inquiries#create'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/thanks' => 'inquiries#thanks'
#  root 'top#index'
  root to: "top#index"
  resources :blogs
end

