Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  get "home/download_pdf"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
