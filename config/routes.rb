Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'statics#home'

    namespace :admin do
      get '/', to: redirect('admin/dashboard')
      root 'dashboard#index'
      get :dashboard, to: 'dashboard#index'
      get :registers, to: 'dashboard#registers'
      get :directories, to: 'dashboard#directories'
      get :requests, to: 'dashboard#requests'
      get '/metrics/period', to: 'metrics#period'

      resources :users, except: :show
      resource :settings, except: :edit
      resources :page_fragments, only: [:index, :edit, :update]
      resources :sections, except: :show do
        collection do
          put :move
        end
      end
      resources :pages, except: [:index, :show]
      resources :pictures, only: [:index, :create, :show, :destroy]
      resources :attachments, only: [:index, :create, :destroy]
    end

    devise_for :users, controllers: { sessions: 'admin/sessions' }
  end
end
