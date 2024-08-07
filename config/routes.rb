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
    resources :post_comments, only: [:index]
    delete 'post_comments', to: 'post_comments#destroy', as: 'delete_post_comment'
  end

  #ユーザー機能
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions",
    passwords: "user/passwords"
  }

  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
  end


  #投稿機能
  resources :posts, only: [:new, :create, :show, :index, :destroy, :edit, :update] do
    resources :post_comments, only: [:create]
    resource :favorite, only: [:create, :destroy, :index]
  end

  #ゲストログイン機能
  devise_scope :user do
  post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end


  #退会機能
  get '/user/check' => 'users#check'
  delete '/user/withdraw' => 'users#withdraw'


  #検索機能
  get "search" => "searches#search"

  #タグ検索
  get "search_tag" => "posts#search_tag"


  get 'homes/top'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #post 'posts/new' => 'posts#create'
end
