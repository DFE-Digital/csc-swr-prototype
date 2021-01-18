Rails.application.routes.draw do
  get "/pages/:page", to: "pages#show"

  get '/case/new', to: "cases#new"
  post '/case/new', to: 'cases#create'
  get '/case/:id', to: 'cases#show'

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all
end
