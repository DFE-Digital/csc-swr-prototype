Rails.application.routes.draw do
  root 'pages#home'

  get "/pages/:page", to: "pages#show"

  get "/gdrive", to: "gdrive#index"
  get "/show/:id", to: "gdrive#show", as: :show
  post "/form", to: "gdrive#form"
  post "/save", to: "gdrive#save"
  patch "/update/:id", to: "gdrive#update", as: :update

  get "/audio", to: "audio#new"
  get "/audio/show/:id", to: "audio#show", as: :audio_show
  post "/upload", to: "audio#upload"
  patch "/audio/update/:id", to: "audio#update", as: :audio_update
  get "status", to: "audio#status"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all
end
