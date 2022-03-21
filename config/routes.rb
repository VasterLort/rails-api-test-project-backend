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
    "http://localhost:8080/user/password/edit"
  end

  direct :front_sign_in do
    "http://localhost:8080/sign_in"
  end
end
