Rails.application.routes.draw do
  root to: 'main#index'

  namespace :api, defaults: {format: :json} do
    namespace 1, module: :v1 do
      resources :apps, only: [:index, :create, :destroy]
    end
  end

  get 'favicon.ico' => redirect { "http:#{ActionController::Base.helpers.asset_path('favicon.ico')}" }
end
