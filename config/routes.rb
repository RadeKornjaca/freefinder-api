Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :users
    post 'device_sign_in', :to => 'users#device_sign_in'
    delete 'device_sign_out', :to => 'users#device_sign_out'

    resources :api_keys

    concern :revisionable do
      resources :revisions, only: [ :index, :create ] do
        member do
          put 'approve'
          put 'disprove'
        end

        collection do
          get 'proposals'
        end
      end
    end

    concern :visitable do
      member do
        post 'visit'
      end
    end

    resources :places, concerns: [:revisionable, :visitable] do
      resources :ratings, only: [ :create ]
    end

    resources :categories, concerns: [:revisionable, :visitable]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
