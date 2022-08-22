Rails.application.routes.draw do
  # registrationsコントローラーはauthというディレクトリの中に作成していく
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  resources :messages, only: ['index'] do
    member do
      resources :likes, only: ['create']
    end
  end
end
