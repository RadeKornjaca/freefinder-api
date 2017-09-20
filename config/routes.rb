Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :users
    post 'device_sign_in', :to => 'users#device_sign_in'
    delete 'device_sign_out', :to => 'users#device_sign_out'

    resources :api_keys

    resources :places do
      resources :ratings, only: [ :create ]
    end

    resources :categories
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
