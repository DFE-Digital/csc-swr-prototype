Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "pages#home"

  get "/pages/:page", to: "pages#show"

  get "/new-media-file", to: "case_documents#new"
  post "/new-media-file", to: "case_documents#create"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all
end
