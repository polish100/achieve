Rails.application.routes.draw do
#get 'about' => 'about#company_overview'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
#  resources :users, only: [:index, :show, :edit, :update]
  resources :users do
        member { get :image }
  end

  # get 'inquiries' => 'inquiries#new'
  # post 'inquiries' => 'inquiries#new'
  # delete 'inquiries/:id' => 'inquiries#destroy'
  # get 'inquiries/index' => 'inquiries#index'
  # get 'inquiries/show' => 'inquiries#show'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/thanks' => 'inquiries#thanks'
  post 'inquiries/new' => 'inquiries#new'

  resources :inquiries

#  root 'top#index'
  root to: "top#index"
  resources :blogs
end
