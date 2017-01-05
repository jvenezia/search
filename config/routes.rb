Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace 1, module: :v1 do
      resources :apps, only: [:create, :destroy]
    end
  end
end
