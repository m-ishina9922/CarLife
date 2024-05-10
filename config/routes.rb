Rails.application.routes.draw do
  devise_for :admin, controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions",
    passwords: "admin/passwords"
  }

  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions",
    passwords: "user/passwords"
  }


  get 'homes/top'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
