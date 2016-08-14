Rails.application.routes.draw do
  # get 'notifications/index'
  #
  # get 'relationships/create'
  #
  # get 'relationships/destroy'

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

  resources :users do
    member { get :image }
  end


  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/thanks' => 'inquiries#thanks'
  post 'inquiries/new' => 'inquiries#new'

  resources :inquiries

  resources :relationships, only: [:create, :destroy]

  resources :users, only: [:index, :show, :edit, :update] do
    resources :tasks
    resources :notifications, only: [:index]
    resources :submit_requests, shallow: true do
      get 'approve'
      get 'unapprove'
      get 'reject'
      collection do
        get 'inbox'
      end
    end
  end

  resources :conversations do
    resources :messages
  end
end
