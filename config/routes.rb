Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      # passwords: 'users/passwords'
  }
  resource :two_factor_settings, except: [:index, :show]
  get "home/download_pdf"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
