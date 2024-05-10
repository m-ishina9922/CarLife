Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
    passwords: "admins/passwords"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }


  get 'homes/top'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
