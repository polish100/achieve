Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  root to: 'top#index'
  resources :blogs do
    resources :comments
    collection do
      post :confirm
    end
  end

  post 'comments' => 'comments#create'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
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

  resources :relationships, only: [:create, :destroy]
end
