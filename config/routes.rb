Rails.application.routes.draw do

  # ============================================================
  # USER ROUTES
  # ============================================================
  delete "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  get "profile" => "registrations#edit", as: "profile"
  post "profile" => "registrations#update", as: "update_profile"
  resources :sessions, only: [:new, :create, :destroy]


  # ============================================================
  # ADMIN ROUTES
  # ============================================================
  scope module: 'admin', path: 'adm1nistr8tion', as: 'admin' do
    #root to: 'dashboard#show', as: :dashboard
    resources :users, only: [:index, :show]
  end


  # ============================================================
  # MAIN ROUTES
  # ============================================================
  resources :forms do
    get 'summary', on: :member
    get 'report', on: :member
    resources :form_entries, path: 'entries'
  end

  resources :reports, only: :index
  root "dashboard#show"

end
