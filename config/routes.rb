Rails.application.routes.draw do

  # ============================================================
  # USER ROUTES
  # ============================================================
  delete "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  get "signup" => "registrations#new", as: "signup"
  get "profile" => "registrations#edit", as: "profile"
  post "profile" => "registrations#update", as: "update_profile"
  get "paswords/:token/edit" => "passwords#edit", as: "change_password"
  resource :password, only: [:new, :create, :edit, :update]
  resources :registrations, except: [:index, :show, :destroy]
  resources :sessions, only: [:new, :create, :destroy]


  # ============================================================
  # PUBLIC ROUTES
  # ============================================================
  scope module: 'public', path: '', as: 'public' do
    get "pages/home", as: :home
    get "pages/features", as: :features
    get "pages/contact", as: :contact
  end


  # ============================================================
  # ADMIN ROUTES
  # ============================================================
  scope module: 'admin', path: 'adm1nistr8tion', as: 'admin' do
    #root to: 'dashboard#show', as: :dashboard
    resources :users, only: [:index, :new, :create] do
      post 'toggle_status', on: :member
    end
  end


  # ============================================================
  # MAIN ROUTES
  # ============================================================
  resources :forms do
    get 'summary', on: :member
    get 'report', on: :member
    resources :form_entries, path: 'entries'
    resources :form_fields
  end

  resources :reports, only: :index

  get "form/:id", to: "public/forms#show", as: :public_form
  post "form/:id", to: "public/forms#create", as: :create_public_form
  get "form/:id/completed", to: "public/forms#completed", as: :completed_public_form

  root "forms#index"

end
