Rails.application.routes.draw do


 #管理者機能
  devise_for :admin, controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions",
    passwords: "admin/passwords"
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'

    resources :users, only: [:destroy, :show, :edit]
  end

  #ユーザー機能
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions",
    passwords: "user/passwords"
  }

  resources :users, only: [:show, :edit, :update]


  #投稿機能
  resources :posts, only: [:new, :create, :show, :index, :destroy, :edit, :update]

  #ゲストログイン機能
  devise_scope :user do
  post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end




  get 'homes/top'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
