Rails.application.routes.draw do
  get 'inquiry' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'
  root 'top#index'
  resources :blogs
end
