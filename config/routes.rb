Rails.application.routes.draw do
  root 'voice_records#index'
  resources :voice_records
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by uptime monitors like Docker or Kubernetes.
  get "up" => "rails/health#show", as: :rails_health_check
end
