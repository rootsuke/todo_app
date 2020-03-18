Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :tasks
      resource :users
    end
  end
end
