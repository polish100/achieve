Rails.application.routes.draw do
  get 'inquiries' => 'inquiries#index'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/thanks' => 'inquiries#thanks'
  root 'top#index'
  resources :blogs
end
