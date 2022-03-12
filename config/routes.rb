Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               confirmations: 'users/confirmations',
               passwords: 'users/passwords'
             }
  get '/member-data', to: 'members#show'
  resources :posts

  direct :front_edit_user_password do
    "http://localhost:8080/users/password/edit"
  end
end
