Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :users
  resources :events do
    resources :event_attendees, only: [:create, :destroy]
  end
  # delete 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
