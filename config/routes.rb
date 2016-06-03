Rails.application.routes.draw do
  post 'authenticate' => 'auth#authenticate'
  resources :users
  resources :projects do
    resources :squares
  end
end
